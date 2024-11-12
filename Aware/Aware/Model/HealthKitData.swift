//
//  HealthKitData.swift
//  Aware
//
//  Created by christian on 11/1/24.
//

import Foundation
import Algorithms

@MainActor
@Observable
final class HealthKitData: Sendable {
    var mindfulnessSessions: [MindfulnessSession] = []
    
    /// Calculate daily total minutes of mindfulness.
    ///
    ///  Uses ``chunked(by:)`` from Swift Algorithms to group the total number of minutes spent in mindfulness sessions by their session date.
    /// - Returns: An array of ``DailyMindfulness``
    func totalMinutesByDay() -> [DailyMindfulness] {
        var mindfulnessByDay: [DailyMindfulness] = []
        
        // Create a sorted list of sessions be descending date
        let sortedSessions = mindfulnessSessions.sorted { $0.sessionDate > $1.sessionDate}
        // Group session data by session date
        let chunkedData = sortedSessions.chunked {
            $0.sessionDate == $1.sessionDate
        }
        
        for day in chunkedData {
            guard let firstValue = day.first else { continue }
            let totalMinutes = day.reduce(0) {
                $0 + Int($1.interval.duration / 60)
            }
            let dailyTotal = DailyMindfulness(
                date: firstValue.sessionDate,
                minutes: totalMinutes
            )
            mindfulnessByDay.append(dailyTotal)
        }
        return mindfulnessByDay
    }
    
    func lastSessionDuration() -> Int {
        guard let lastSession = mindfulnessSessions.last else { return 0 }
        return Int(lastSession.interval.duration) / 60
    }
    
    func averageSessionDuration() -> Int {
        let durations = mindfulnessSessions.map { Int($0.interval.duration) / 60 }
        return durations.average
    }
    
    func totalMinutesToday() -> Int {
        let todaysSessions = mindfulnessSessions.filter({$0.sessionDate.weekdayInt == Date.now.weekdayInt})
        let totalMinutes = todaysSessions.reduce(0) {
            $0 + Int($1.interval.duration / 60)
        }
        return totalMinutes
    }
}
