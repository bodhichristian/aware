//
//  HealthMetric.swift
//  Aware
//
//  Created by christian on 10/25/24.
//

import Foundation

struct MindfulnessSession: Hashable, Identifiable {
    let id = UUID()
    let interval: DateInterval
    
    var sessionDate: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: interval.start)
    }
}
