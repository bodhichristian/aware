//
//  AwareApp.swift
//  Aware
//
//  Created by christian on 10/25/24.
//
//
import SwiftUI
import SwiftData

@main
struct AwareApp: App {
    let hkService = HealthKitService()
    let hkData = HealthKitData()
    let appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            AppContainer()
                .environment(appState)
                .environment(hkService)
                .environment(hkData)
                .preferredColorScheme(.dark)
        }
    }
}
