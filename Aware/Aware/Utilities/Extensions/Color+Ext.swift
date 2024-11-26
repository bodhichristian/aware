//
//  Color+Ext.swift
//  Aware
//
//  Created by christian on 11/6/24.
//

import Foundation
import SwiftUI

extension Color {
    /// Create an adaptation of ``self`` based on daily total minutes of mindfulness
    /// - Parameter minutes: ``Int`` representing number of minutes
    /// - Returns: ``self`` with an applied opacity, or a default color
    func progressOpacity(from minutes: Int) -> Color {
        if minutes >= 15 {
            return self
        } else if minutes >= 10 {
            return self.opacity(0.8)
        } else if minutes >= 5 {
            return self.opacity(0.4)
        } else if minutes >= 1 {
            return self.opacity(0.2)
        } else {
            return .white.opacity(0.1)
        }
    }
}
