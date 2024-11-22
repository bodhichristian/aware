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
    let style = AppStyle(palette: .indigo)
    let user = User(firstName: "", dailyGoalMinutes: 7)
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(hkService)
                .environment(hkData)
                .environment(style)
                .environment(user)
                .preferredColorScheme(.dark)
        }
    }
}
