//
//  AppState.swift
//  Aware
//
//  Created by christian on 11/24/24.
//

import Foundation
import SwiftUI

@Observable
class AppState {
    enum AppScene {
        case launched, onboarding, main, inSession
    }
    
    var scene: AppScene = .onboarding
    var dailyGoal: Int = 7
    var theme: Palette = .earth
    static let cornerRadius: CGFloat = 16
}

enum OnboardingPhase {
    case name, goal, theme
    
    var prompt: String {
        switch self {
        case .name:
            "What's your name?"
        case .goal:
            "What's your daily goal?"
        case .theme:
            "Select a theme"
        }
    }
    
    var subtitle: String {
        switch self {
        case .name:
            ""
        case .goal:
            "You can change this later in Settings"
        case .theme:
            "Select a theme to get started."
        }
    }
}
