//
//  User.swift
//  Aware
//
//  Created by christian on 11/13/24.
//

import Foundation
import SwiftData

@Model
final class User {
    var firstName: String
    var dailyGoalMinutes: Int
    var inSession: Bool
    
    init(firstName: String, dailyGoalMinutes: Int) {
        self.firstName = firstName
        self.dailyGoalMinutes = dailyGoalMinutes
        self.inSession = false
    }
}
