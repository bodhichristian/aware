//
//  DashboardView.swift
//  Aware
//
//  Created by christian on 11/6/24.
//

import SwiftUI

struct DashboardView: View {
    @Binding var inSession: Bool
    @Environment(HealthKitData.self) var hkData
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                GaugeView(engaged: $inSession)
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
                    footer: "View trends",
                    footerSymbol: "chart.bar.fill"
                )
                HabitGrid(data: hkData.totalMinutesByDay(), color: .accentPurple)
                InsightTile(
                    header: "Daily Inspiration",
                    content: "\"The only zen you'll find on mountain tops is the zen you bring up there with you.\"",
                    footer: "View more",
                    footerSymbol: "quote.opening"
                )
            }
            .padding(.horizontal)
        }
        .scrollIndicators(.never)
        .transition(.opacity)
    }
}

#Preview {
    DashboardView(inSession: .constant(false))
}