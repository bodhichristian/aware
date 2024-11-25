//
//  SessionTimer.swift
//  Aware
//
//  Created by christian on 11/5/24.
//

import SwiftUI
import HealthKit

struct SessionTimer: View {
    @Environment(AppState.self) var appState
    @Environment(HealthKitService.self) var hkService
    @Environment(HealthKitData.self) var hkData
    @State private var startTime: Date = .now
    @State private var elapsedTime: TimeInterval = 0
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text(elapsedTime.timerFormat())
                .font(.title2)
                .foregroundStyle(.secondary)
                .padding()
                .frame(maxWidth: .infinity)
                .contentTransition(.numericText())

        }
        .onReceive(timer) { _ in
            if appState.scene == .inSession {
                elapsedTime = Date().timeIntervalSince(startTime)
            } else {
                stopTimer()
            }
        }
        .onChange(of: appState.scene) {
            if appState.scene != .inSession {
                addTimeToHealth()
                stopTimer()
            }
        }
    }
    
    private func addTimeToHealth() {
        Task {
            // Insert new data
            let newInterval = DateInterval(start: startTime, duration: elapsedTime)
            try await hkService.addMindfulnessData(for: newInterval)
            // Fetch from Health
            async let fetch = hkService.fetchMindfulnessData()
            try await hkData.mindfulnessSessions = fetch
        }
    }

    private func stopTimer() {
        appState.scene = .main
    }
}

#Preview {
    SessionTimer()
}
