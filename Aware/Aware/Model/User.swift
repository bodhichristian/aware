//
//  User.swift
//  Aware
//
//  Created by christian on 11/13/24.
//

import Foundation
import SwiftData

@Observable
final class User {
    var firstName: String
    var dailyGoalMinutes: Int
    var selectedPalette: Palette
    var isOnboarded: Bool
    
    init(firstName: String, dailyGoalMinutes: Int, selectedPalette: Palette) {
        self.firstName = firstName
        self.dailyGoalMinutes = dailyGoalMinutes
        self.selectedPalette = selectedPalette
        self.isOnboarded = false
    }
}


