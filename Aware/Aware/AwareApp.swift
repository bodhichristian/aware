//
//  AwareApp.swift
//  Aware
//
//  Created by christian on 10/25/24.
//

import SwiftUI

@main
struct AwareApp: App {
    let hkService = HealthKitService()
    let hkData = HealthKitData()
    let style = AppStyle(theme: .indigo)
    
    var body: some Scene {
        WindowGroup {
            MindfulnessDashboard()
                .environment(hkService)
                .environment(hkData)
                .environment(style)
                .preferredColorScheme(.dark)
        }
    }
}
