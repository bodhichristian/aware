//
//  Theme.swift
//  Aware
//
//  Created by christian on 11/14/24.
//

import Foundation
import SwiftUI

enum Palette {
    case indigo, green, earth, gray
    
    var background: Color {
        switch self {
        case .indigo:
                .backgroundBlue
        case .green:
                .backgroundGreen
        case .earth:
                .backgroundEarth
        case .gray:
                .backgroundGray
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
        case .gray:
                .tileHeaderGray
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
        case .gray:
                .tileBodyGray
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
        case .gray:
                .accentPink
        }
    }
    
    var meshColors: [Color] {
        AWStyle.meshFor(self.background)
    }
}
