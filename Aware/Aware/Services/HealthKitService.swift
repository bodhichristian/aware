//
//  HealthKitService.swift
//  Aware
//
//  Created by christian on 10/25/24.
//

import Foundation
import HealthKit
import Observation


@MainActor
@Observable
class HealthKitService {
    
    let store = HKHealthStore()
    
    let types: Set = [HKCategoryType(.mindfulSession)]
    
    let permissionPrimer: String = """
    Share mindfulness sessions with Apple Health, and get useful insights.
    
    Your data is your data. The information available inside this app is only accessible on your device.
    """
    
    /// Add pre-defined mock data to HealthKit on the Simulator
    func addSampleData() async throws {
        
        var sampleData: [HKCategorySample] = []
        
        let calendar = Calendar.current
        
        for i in 0...130 {
            // Create a start date that is `i` number of days before today
            let start = calendar.date(byAdding: .day, value: -i, to: .now)
            // Calculate an end that is 1-15 minutes after the start date
            let end = calendar.date(byAdding: .minute, value: Int.random(in: 0...17), to: start!)
            // Create an HKCategorySample for mindfulness data sample
            let mindfulnessDataSample = HKCategorySample(
                type: HKCategoryType(.mindfulSession),
                value: 0,
                start: start!,
                end: end!
            )
            // Add new sample to `sampleData`
            sampleData.append(mindfulnessDataSample)
        }
        // Add sample data to HealthKit
        do {
            try await store.save(sampleData)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Write mindful minute data to HealthKit. This requires HealthKit write permission.
    /// - Parameters:
    ///   - interval: a ``DateInterval``  representing the start and end of the session
    func addMindfulnessData(for interval: DateInterval) async throws {
        let status = store.authorizationStatus(for: HKCategoryType(.mindfulSession))
        
        switch status {
        case .notDetermined:
            throw AWError.authNotDetermined
        case .sharingDenied:
            throw AWError.sharingDenied(quantityType: "Mindful minutes")
        case .sharingAuthorized:
            break
        @unknown default:
            break
        }
        
        let mindfulMinuteData = HKCategorySample(
            type: HKCategoryType(.mindfulSession),
            value: 0,
            start: interval.start,
            end: interval.end
        )
        
        do {
            try await store.save(mindfulMinuteData)
        } catch {
            throw AWError.unableToCompleteRequest
        }
    }
    
    /// Fetch mindful minutes sessions from each day for a specified number of days back from today.
    func fetchMindfulnessData() async throws -> [MindfulnessSession] {
        // Guard against unknown authorization status
        guard store.authorizationStatus(for: HKCategoryType(.mindfulSession)) != .notDetermined else {
            throw AWError.authNotDetermined
        }
        // Calculate an end date based on the provided `daysBack`
        //let startDate = Calendar.current.date(byAdding: .day, value: -daysBack, to: .now)
        // Create predicate for HealthKit query
        let queryPredicate = HKQuery.predicateForSamples(
            withStart: .distantPast,
            end: .now
        )
        // Create a query for Mindful Sessions
        let mindfulSessionQuery = HKSampleQueryDescriptor(
            predicates: [.categorySample(
                type: HKCategoryType(.mindfulSession),
                predicate: queryPredicate
            )],
            sortDescriptors: [SortDescriptor(\.startDate, order: .forward)]
        )
        var sessions: [MindfulnessSession] = []
        
        do {
            // Fetch mindful session samples from HealthKit store
            let samples = try await mindfulSessionQuery.result(for: store)
            // Loop through samples to create MindfulnessSession objects
            for sample in samples {
                let interval = DateInterval(start: sample.startDate, end: sample.endDate)
                let session = MindfulnessSession(interval: interval)
                sessions.append(session)
            }
            return sessions
        } catch HKError.errorNoData {
            throw AWError.noData
        } catch {
            throw AWError.unableToCompleteRequest
        }
    }

}

