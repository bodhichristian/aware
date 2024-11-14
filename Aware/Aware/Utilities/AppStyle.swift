//
//  Theme.swift
//  Aware
//
//  Created by christian on 11/14/24.
//

import Foundation
import SwiftUI

@Observable
class AppStyle {
    var theme: Theme
    
    init(theme: Theme) {
        self.theme = .indigo
    }
    
    func setGreenTheme() {
        theme = .green
    }
    
    func setEarthTheme() {
        theme = .earth
    }
}

enum Theme {
    case indigo, green, earth
    
    var background: Color {
        switch self {
        case .indigo:
                .backgroundBlue
        case .green:
                .backgroundGreen
        case .earth:
                .backgroundEarth
        }
    }
    
    var tileHeader: Color {
        switch self {
        case .indigo:
                .tileHeaderBlue
        case .green:
                .tileHeaderGreen
        case .earth:
                .tileHeaderEarth
        }
    }
    
    var tilteBody: Color {
        switch self {
        case .indigo:
                .tileBodyBlue
        case .green:
                .tileBodyGreen
        case .earth:
                .tileBodyEarth
        }
    }
    
    var accentColor: Color {
        switch self {
        case .indigo:
                .accentPurple
        case .green:
                .accentSage
        case .earth:
                .accentOrange
        }
    }
    
    var meshColors: [Color] {
        AWStyle.meshFor(self.background)
    }
}
