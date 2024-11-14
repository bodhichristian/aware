//
//  User.swift
//  Aware
//
//  Created by christian on 11/13/24.
//

import Foundation

@Observable
class User {
    var firstName: String
    var dailyMinutesGoal: Int
    var inSession: Bool
    
    init(firstName: String, dailyMinutesGoal: Int) {
        self.firstName = firstName
        self.dailyMinutesGoal = 7
        self.inSession = false
    }
}
