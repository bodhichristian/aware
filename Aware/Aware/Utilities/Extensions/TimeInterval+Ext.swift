//
//  TimeInterval+Ext.swift
//  Aware
//
//  Created by christian on 11/6/24.
//

import Foundation

extension TimeInterval {
    func minutesSecondsString() -> String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}