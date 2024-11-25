//
//  ContentView.swift
//  Aware
//
//  Created by christian on 10/25/24.
//

import SwiftUI
import HealthKit
import HealthKitUI

struct HomeView: View {
    @Environment(HealthKitData.self) var hkData
    @Environment(HealthKitService.self) var hkService
    @Environment(AppState.self) var appState
    @State private var showingPrimer = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                MindfulMeshGradient()
                switch appState.scene {
                case .inSession:
                    SessionView()
                case .main:
                    DashboardView()
                case .onboarding:
                    OnboardingView()
                }
            }
        }
        .fullScreenCover(isPresented: $showingPrimer) {
            HKPermissionPrimerView()
        }
        .task {
            fetchHealthData()
            // MARK: Add sample data to simulator
            //            Task { @MainActor in
            //                if hkData.mindfulnessSessions.isEmpty {
            //                    try await hkService.addSampleData()
            //                }
            //            }
        }
        
    }
    
    private func fetchHealthData() {
        Task {
            do {
                async let data = try await hkService.fetchMindfulnessData()
                hkData.mindfulnessSessions = try await data
            } catch AWError.authNotDetermined {
                showingPrimer = true
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(HealthKitService())
        .environment(HealthKitData())
        .preferredColorScheme(.dark)
}




// MARK: - Attach this modifier to add sample data to the Health app on the iOS siumulator
//.toolbar {
//    ToolbarItem (placement: .topBarLeading){
//        Button("Add Sample Data") {
//            Task {
//                try await hkService.addSampleData()
//            }
//        }
//    }
//}
