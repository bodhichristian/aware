//
//  ContentView.swift
//  Aware
//
//  Created by christian on 10/25/24.
//

import SwiftUI
import HealthKit
import HealthKitUI

struct MindfulnessDashboard: View {
    @Environment(HealthKitData.self) var hkData
    @Environment(HealthKitService.self) var hkService
    @State private var inSession = false
    @State private var showingPrimer = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                MindfulMeshGradient(engaged: $inSession)
                switch inSession {
                case true:
                    SessionView(inSession: $inSession)
                case false:
                    DashboardView(inSession: $inSession)
                }
            }
        }
        .fullScreenCover(isPresented: $showingPrimer) {
            HKPermissionPrimerView()
        }
        .task {
            
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
    MindfulnessDashboard()
        .environment(HealthKitService())
        .environment(HealthKitData())
}





//.toolbar {
//
//}

//#if DEBUG
//                ToolbarItem (placement: .topBarLeading){
//                    Button("Add Sample Data") {
//                        Task {
//                            try await hkService.addSampleData()
//                        }
//                    }
//                }
//#endif
