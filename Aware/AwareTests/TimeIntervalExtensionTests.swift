//
//  TimeIntervalExtensionTests.swift
//  AwareTests
//
//  Created by christian on 11/11/24.
//

import Testing
import Foundation
@testable import Aware

struct TimeIntervalExtensionTests {

    @Test func timerFormatPresentsMinutesPlaceholder() {
        let interval: TimeInterval = 10
        let expectedFormat: String = "00:10"
        let formattedString = interval.timerFormat()
        
        #expect(formattedString == expectedFormat)
    }

    @Test func timerFormatAccountsForMinutes() {
        let interval: TimeInterval = 120
        let expectedFormat: String = "02:00"
        let formattedString = interval.timerFormat()
        
        #expect(formattedString == expectedFormat)
    }
}
