//
//  Color+Ext.swift
//  Aware
//
//  Created by christian on 11/6/24.
//

import Foundation
import SwiftUI

extension Color {
    func progressOpacity(from minutes: Int) -> Color {
        if minutes >= 15 {
            return self
        } else if minutes >= 10 {
            return self.opacity(0.7)
        } else if minutes >= 5 {
            return self.opacity(0.3)
        } else {
            return .white.opacity(0.1)
        }
    }
}
