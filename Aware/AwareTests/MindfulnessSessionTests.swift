//
//  MindfulnessSessionTests.swift
//  AwareTests
//
//  Created by christian on 12/3/24.
//

import Testing
import Foundation
@testable import Aware

struct MindfulnessSessionTests {

    @Test func sessionDateIsTodaysDate() async throws {
        let interval = DateInterval(start: .now, end: .now)
        let session = MindfulnessSession(interval: interval)
        
        #expect(session.sessionDate.weekdayInt == Date.now.weekdayInt)
    }
    
    @Test func initializesWithUniqueID() {
        let session1 = MindfulnessSession(interval: DateInterval(start: .now, end: .now))
        let session2 = MindfulnessSession(interval: DateInterval(start: .now, end: .now))
        
        #expect(session1.id != session2.id)
    }
}
