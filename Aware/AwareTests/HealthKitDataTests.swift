//
//  HealthKitDataTests.swift
//  AwareTests
//
//  Created by christian on 12/3/24.
//

import Testing
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
}
