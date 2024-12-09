//
//  HealthKitDataTests.swift
//  AwareTests
//
//  Created by christian on 12/3/24.
//

import Testing
import Foundation
@testable import Aware

struct HealthKitDataTests {

    @MainActor @Test func initWithEmptyDataSet() {
        let hkData = HealthKitData()
        #expect(hkData.mindfulnessSessions.isEmpty)
        #expect(hkData.lastSessionDuration == 0)
        #expect(hkData.averageSessionDuration == 0)
        #expect(hkData.totalMinutesToday == 0)
        #expect(hkData.totalSessionsToday == 0)
    }
    
    @MainActor @Test func lastSessionDuration() {
        let hkData = HealthKitData()
        
        hkData.mindfulnessSessions = TestHelper.sampleSessions()
        
        let lastSessionDuration = hkData.lastSessionDuration
        #expect(lastSessionDuration == 0)
        
    }
    
    @MainActor @Test func averageSessionDurationReturnsZeroWhenNoSessions() {
        let hkData = HealthKitData()
        #expect(hkData.averageSessionDuration == 0)
    }
    
    @MainActor @Test func averageSessionDurationCalculatesCorrectAverage() {
        let hkData = HealthKitData()
        hkData.mindfulnessSessions = TestHelper.sampleSessions()
        let average = hkData.averageSessionDuration
        #expect(average == 3)
    }
    
    @MainActor @Test func totalMinutesTodayCalculatesCorrectTotal() {
        let hkData = HealthKitData()
        hkData.mindfulnessSessions = TestHelper.sampleSessions()
        let totalMinutesToday = hkData.totalMinutesToday
        #expect(totalMinutesToday == 0.0)
    }
    
    @MainActor @Test func totalSessionsTodayCalculatesCorrectTotal() {
        let hkData = HealthKitData()
        hkData.mindfulnessSessions = TestHelper.sampleSessions()
        let totalSessionsCheck1 = hkData.totalSessionsToday
        #expect(totalSessionsCheck1 == 1)
        hkData.mindfulnessSessions += TestHelper.sampleSessions()
        let totalSessionsCheck2 = hkData.totalSessionsToday
        #expect(totalSessionsCheck2 == 2)
    }

    
    @MainActor  @Test func totalMinutesByDayChunksMindfulnessData() {
        let hkData = HealthKitData()
        let sessions = TestHelper.sampleSessions() + TestHelper.sampleSessions()
        hkData.mindfulnessSessions = TestHelper.sampleSessions()
        let chunked = hkData.totalMinutesByDay()
        
        #expect(chunked.count == 8)
    }
}


