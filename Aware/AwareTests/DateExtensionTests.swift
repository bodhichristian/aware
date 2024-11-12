//
//  DateExtensionTests.swift
//  AwareTests
//
//  Created by christian on 11/11/24.
//

import Testing
import Foundation
@testable import Aware

struct DateExtensionTests {
    @Test func weekdayIntForKnownSunday() async throws {
        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = 11
        dateComponents.day = 10
        
        let date = Calendar.current.date(from: dateComponents)!
        
        #expect(date.weekdayInt == 1)
    }
    
    @Test func weekdayIntForKnownMonday() {
        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = 11
        dateComponents.day = 11
        
        let date = Calendar.current.date(from: dateComponents)!
        
        #expect(date.weekdayInt == 2)
    }
    
    @Test func weekdayIntForKnownTuesday() {
        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = 11
        dateComponents.day = 12
        
        let date = Calendar.current.date(from: dateComponents)!
        
        #expect(date.weekdayInt == 3)
    }
    
    @Test func weekdayIntForKnownWednesday() {
        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = 11
        dateComponents.day = 13
        
        let date = Calendar.current.date(from: dateComponents)!
        
        #expect(date.weekdayInt == 4)
    }
    
    @Test func weekdayIntForKnownThursday() {
        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = 11
        dateComponents.day = 14
        
        let date = Calendar.current.date(from: dateComponents)!
        
        #expect(date.weekdayInt == 5)
    }
    
    @Test func weekdayIntForKnownFriday() {
        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = 11
        dateComponents.day = 15
        
        let date = Calendar.current.date(from: dateComponents)!
        
        #expect(date.weekdayInt == 6)
    }
    
    @Test func weekdayIntForKnownSaturday() {
        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = 11
        dateComponents.day = 16
        
        let date = Calendar.current.date(from: dateComponents)!
        
        #expect(date.weekdayInt == 7)
    }
}
