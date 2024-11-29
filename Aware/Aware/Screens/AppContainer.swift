//
//  ContentView.swift
//  Aware
//
//  Created by christian on 10/25/24.
//

import SwiftUI
import HealthKit
import HealthKitUI

struct AppContainer: View {
    @Environment(HealthKitData.self) var hkData
    @Environment(HealthKitService.self) var hkService
    @Environment(AppState.self) var appState
    @State private var showingPrimer = false
    @AppStorage("hasOnboarded") private var hasOnboarded: Bool = false
    @AppStorage("theme") private var themeKey: String = Palette.green.key
    
    var body: some View {
        NavigationStack {
            ZStack {
                MindfulMeshGradient()
                switch appState.scene {
                case .launched:
                    EmptyView()
                case .onboarding:
                    OnboardingView()
                case .main:
                    DashboardView()
                case .inSession:
                    SessionView()
                }
            }
        }
        .fullScreenCover(isPresented: $showingPrimer) {
            HKPermissionPrimerView()
        }
        .onAppear {
            appState.theme = Palette.from(themeKey)
            if hasOnboarded {
                appState.scene = .main
            }
        }
        .onChange(of: appState.theme) {
            themeKey = appState.theme.key
        }
        .task {
//             MARK: Add sample data to simulator
//                        Task { @MainActor in
//                            if hkData.mindfulnessSessions.isEmpty {
//                                try await hkService.addSampleData()
//                            }
//                        }
            fetchHealthData()
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
    AppContainer()
        .environment(HealthKitService())
        .environment(HealthKitData())
        .preferredColorScheme(.dark)
}
