//
//  TestHelper.swift
//  Aware
//
//  Created by christian on 12/5/24.
//

import Foundation
import HealthKit

@testable import Aware

struct TestHelper {
    /// Create 8 days of sample data, where each day has a single ``MindfulnessSession``
    /// - Returns: An array of 8 MindfulnessSession objects, each with a unique date and duration.
    static func sampleSessions() -> [MindfulnessSession]{
        var sessions: [MindfulnessSession] = []
        let calendar = Calendar.current
        
        for i in 0...7 {
            let start = calendar.date(byAdding: .day, value: -i, to: .now)
            let end = calendar.date(byAdding: .minute, value: i, to: start!)
            let interval = DateInterval(start: start!, end: end!)
            let session = MindfulnessSession(interval: interval)
            sessions.append(session)
        }
        return sessions.reversed()
    }
}

//class MockHealthStore: HKHealthStore, @unchecked Sendable {
//    override func
//}
