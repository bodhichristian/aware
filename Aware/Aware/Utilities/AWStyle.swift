//
//  SNStyle.swift
//  Aware
//
//  Created by christian on 10/29/24.
//

import Foundation
import SwiftUI

struct AWStyle {
    static func extendedGradient(for color: Color) -> LinearGradient {
        LinearGradient(
            colors: [
                color.opacity(0.1),
                color.opacity(0.1),
                color.opacity(0.2),
                color.opacity(0.3)
            ],
            startPoint: .bottom,
            endPoint: .top
        )
    }
    
    static func minimalGradient(for color: Color) -> LinearGradient {
        LinearGradient(
            colors: [
                color.opacity(1.0),
                color.opacity(0.3)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    static func meshFor(_ color: Color) -> [Color] {
        [
            color, color, color,
            color, color, color,
            color.opacity(0.2), color.opacity(0.2), color.opacity(0.2),
            color.opacity(0.2), color.opacity(0.2), color.opacity(0.2)
        ]
    }
}
