//
//  DailyMindfulness.swift
//  Aware
//
//  Created by christian on 11/1/24.
//

import Foundation

struct DailyMindfulness: Identifiable {
    let id = UUID()
    let date: Date
    let minutes: Int
}
