//
//  MockData.swift
//  Aware
//
//  Created by christian on 11/1/24.
//

import Foundation

struct MockData {
    static func mindfulnessSessions() -> [MindfulnessSession] {
        var mockData: [MindfulnessSession] = []
        
        let calendar = Calendar.current
        
        for i in 0...111 {
            // Create a start date that is `i` number of days before today
            let start = calendar.date(byAdding: .day, value: -i, to: .now)
            // Calculate an end that is 1-15 minutes after the start date
            let end = calendar.date(byAdding: .minute, value: Int.random(in: 0...16), to: start!)
            
            let interval = DateInterval(start: start!, end: end!)
            let session = MindfulnessSession(interval:  interval)
            mockData.append(session)
        }
        return mockData
    }
    
    static func dailyMindfulness() -> [DailyMindfulness] {
        var mockData: [DailyMindfulness] = []
        
        let calendar = Calendar.current
        
        for i in 0...111 {
            // Create a start date that is `i` number of days before today
            let date = calendar.date(byAdding: .day, value: -i, to: .now)!
            // Calculate an end that is 1-15 minutes after the start date
            let totalMinutes = Int.random(in: 0...22)
            let dailyTotal = DailyMindfulness(date: date, minutes: totalMinutes)
            mockData.append(dailyTotal)
        }
        return mockData
    }
}
