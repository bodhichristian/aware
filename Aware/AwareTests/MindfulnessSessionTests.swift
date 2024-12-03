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
        let interval = DateInterval(start: .now, end: .now)
        let session1 = MindfulnessSession(interval: interval)
        let session2 = MindfulnessSession(interval: interval)
        
        #expect(session1.id != nil)
        #expect(session1.id != session2.id)
        #expect(type(of: session1.id) == UUID.self)
    }
}
