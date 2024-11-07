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
    @State private var practicingMindfulness = false
    @State private var showingPrimer = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                MindfulMeshGradient(engaged: $practicingMindfulness)
                
                if !practicingMindfulness {
                    ScrollView {
                        VStack(spacing: 16) {
                            GaugeView(engaged: $practicingMindfulness)
                            HStack(spacing: 16) {
                                DataTile(
                                    header: "Last Session",
                                    headerSymbol: "brain.head.profile",
                                    statString: "\(hkData.lastSessionDuration()) min",
                                    bodySymbol: "gauge.medium"
                                )
                                DataTile(
                                    header: "Average",
                                    headerSymbol: "chart.line.uptrend.xyaxis",
                                    statString: "\(hkData.averageSessionDuration()) min",
                                    bodySymbol: "gauge.high"
                                )
                            }
                            InsightTile(
                                header: "Keep it up",
                                content: "You've had more moments of mindfulness this week than last.",
                                cta: "View trends",
                                ctaSymbol: "chart.bar.fill"
                            )
                            
                            
                            HabitGrid(data: hkData.totalMinutesByDay(), color: .accentPurple)
                            
                            InsightTile(
                                header: "Daily Inspiration",
                                content: "\"The only zen you'll find on mountain tops is the zen you bring up there with you.\"",
                                cta: "View more",
                                ctaSymbol: "quote.opening"
                            )
                            
                           
                            
                        }
                        .padding(.horizontal)
                    }
                    .scrollIndicators(.never)
                    .transition(.opacity)
                }
            }
            .navigationTitle("Mindfulness")
            //            .toolbar {
            //                ToolbarItem {
            //                    Button("Add Sample Data") {
            //                        Task {
            //                            try await hkService.addSampleData()
            //                        }
            //                    }
            //                }
            //            }
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
            } catch AWError.noData {
                print("no data")
            } catch {
                print("try again ")
            }
        }
    }
}

#Preview {
    MindfulnessDashboard()
        .environment(HealthKitService())
        .environment(HealthKitData())
}
