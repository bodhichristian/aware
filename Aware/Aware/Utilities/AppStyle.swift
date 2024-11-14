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
    var palette: Palette
    
    init(palette: Palette) {
        self.palette = palette
    }
    
    func setGreenTheme() {
        palette = .green
    }
    
    func setEarthTheme() {
        palette = .earth
    }
}

enum Palette {
    case indigo, green, earth, purple
    
    var background: Color {
        switch self {
        case .indigo:
                .backgroundBlue
        case .green:
                .backgroundGreen
        case .earth:
                .backgroundEarth
        case .purple:
                .backgroundPurple
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
        case .purple:
                .tileHeaderPurple
        }
    }
    
    var tileBody: Color {
        switch self {
        case .indigo:
                .tileBodyBlue
        case .green:
                .tileBodyGreen
        case .earth:
                .tileBodyEarth
        case .purple:
                .tileBodyPurple
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
        case .purple:
                .accentPink
        }
    }
    
    var meshColors: [Color] {
        AWStyle.meshFor(self.background)
    }
}
