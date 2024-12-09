//
//  AWErrorTests.swift
//  AwareTests
//
//  Created by christian on 12/6/24.
//

import Testing
import HealthKit
@testable import Aware

struct HealthKitServiceTests {
    // MARK: Error Handling
    @Test func addMindfulnessData() async throws {
        let hkService = HealthKitService()
        
        let interval = DateInterval(start: .now, end: Calendar.current.date(byAdding: .minute, value: 10, to: .now)!)
        

    }

}
