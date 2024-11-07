//
//  SessionTimer.swift
//  Aware
//
//  Created by christian on 11/5/24.
//

import SwiftUI
import HealthKit

struct SessionTimer: View {
    @Binding var inSession: Bool
    @Environment(HealthKitService.self) var hkService
    @State private var startTime: Date = .now
    @State private var elapsedTime: TimeInterval = 0
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text(elapsedTime.minutesSecondsString())
                .font(.title2)
                .foregroundStyle(.secondary)
                .padding()
                .frame(maxWidth: .infinity)
                .contentTransition(.numericText())

        }
        .onReceive(timer) { _ in
            if inSession {
                elapsedTime = Date().timeIntervalSince(startTime)
            } else {
                stopTimer()
            }
        }
        .onChange(of: inSession) {
            if !inSession {
                addTimeToHealth()
                stopTimer()
            }
        }
    }
    
    private func addTimeToHealth() {
        Task {
            let newInterval = DateInterval(start: startTime, duration: elapsedTime)
            try await hkService.addMindfulnessData(for: newInterval)
        }
    }

    private func stopTimer() {
        inSession = false
    }

    private func resetTimer() {
        inSession = false
        elapsedTime = 0
    }
}

#Preview {
    SessionTimer(inSession: .constant(true))
}
