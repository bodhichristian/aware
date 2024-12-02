//
//  DashboardView.swift
//  Aware
//
//  Created by christian on 11/6/24.
//

import SwiftUI

struct DashboardView: View {
    @Environment(AppState.self) var appState
    @Environment(HealthKitData.self) var hkData
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                headerView
                GaugeView()
                InsightTile(
                    header: "Daily Inspiration",
                    content: "\"The only zen you'll find on mountain tops is the zen you bring up there with you.\"",
                    footer: "View more",
                    footerSymbol: "quote.opening"
                )
                
                HStack(spacing: 16) {
                    DataTile(
                        header: "Today",
                        headerSymbol: "calendar",
                        value: hkData.totalSessionsToday,
                        unit: "sessions"
                    )
                    .accessibilityLabel("\(hkData.totalSessionsToday) sessions today")
                    
                    DataTile(
                        header: "Last Session",
                        headerSymbol: "brain.head.profile",
                        value: hkData.lastSessionDuration,
                        unit: "minutes"
                    )
                    .accessibilityLabel("Last session lasted \(hkData.lastSessionDuration) minutes")
                    
                    DataTile(
                        header: "Average",
                        headerSymbol: "chart.line.uptrend.xyaxis",
                        value: hkData.averageSessionDuration,
                        unit: "minutes"
                    )
                    .accessibilityLabel("Average session duration: \(hkData.averageSessionDuration) minutes")
                }
                
                HabitGrid(data: hkData.totalMinutesByDay())
                    .shadow(radius: 4, x: 4)
                   

                InsightTile(
                    header: "Keep it up",
                    content: "You've had more moments of mindfulness this week than last.",
                    footer: "View trends",
                    footerSymbol: "chart.bar.fill"
                )
            }
            .padding(.horizontal)
        }
        .scrollIndicators(.never)
        .transition(.opacity)
        .padding(.horizontal)
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Aware")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)
                Text("Mindfulness Dashboard")
                    .font(.headline)
                    .foregroundStyle(.white.gradient)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Menu {
                Section("Select a theme") {
                    Button("Green") {
                        withAnimation {
                            appState.theme = .green
                        }
                    }
                    Button("Indigo") {
                        withAnimation{
                            appState.theme = .indigo
                        }
                    }
                    Button("Earth") {
                        withAnimation{
                            appState.theme = .earth
                        }
                    }
                    Button("Gray") {
                        withAnimation {
                            appState.theme = .gray
                        }
                    }
                }
            } label: {
                Image(systemName: "line.3.horizontal")
                    .font(.title2)
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Menu")
        }
    }
}

#Preview {
    DashboardView()
        .environment(HealthKitData())
        .preferredColorScheme(.dark)
}
