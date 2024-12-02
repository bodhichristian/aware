//
//  GaugeView.swift
//  Aware
//
//  Created by christian on 10/29/24.
//

import SwiftUI

struct GaugeView: View {
    @Environment(AppState.self) var appState
    @Environment(HealthKitData.self) var hkData
    @State private var showingAlert: Bool = false
    @AppStorage("dailyGoal") private var dailyGoal: Int = 7
    
    private var progress: Double {
        let progressRatio = hkData.totalMinutesToday / Double(dailyGoal)
        
        if progressRatio > 0.0 {
            return progressRatio
        } else {
            return 0.02 // Ensures progress indication always exists
        }
    }
    
    private var gradient: LinearGradient {
        LinearGradient(
            colors: [appState.theme.accentColor, .white],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 36.0)
                .foregroundStyle(appState.theme.background.mix(with: .black, by: 0.1).gradient)
                .shadow(radius: 4, y: 4)
            
            Circle()
                .stroke(lineWidth: 30.0)
                .foregroundStyle(appState.theme.background)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 30.0, lineCap: .round))
                .foregroundStyle(gradient)
                .rotationEffect(Angle(degrees: 270.0))
            VStack {
                Button { // Daily Goal
                    showingAlert.toggle()
                } label: {
                    VStack {
                        Text("Daily Goal")
                            .font(.title)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .transition(.blurReplace())
                        
                        Text("\(dailyGoal) min")
                            .font(.headline)
                            .foregroundStyle(appState.theme.accentColor.gradient)
                    }
                }
                
                Button { // Start Session
                    withAnimation(.smooth(duration: 1)){
                        appState.scene = .inSession
                    }
                } label: {
                    Text("Start session")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .padding()
                        .background {
                            Capsule()
                                .foregroundStyle(appState.theme.tileHeader)
                                .frame(height: 44)
                                .shadow(radius: 4, y: 4)
                        }
                }
            }
            .offset(y: 10)
        }
        .padding(30)
        .frame(maxWidth: 320, maxHeight: 320)
        .sheet(isPresented: $showingAlert) {
            VStack {
                Text("What's your daily goal?")
                    .font(.title2)
                    .fontWeight(.medium)
                
                HStack {
                    Picker("Daily Goal", selection: $dailyGoal) {
                        ForEach(0..<60) { minutes in
                            Text(String(minutes))
                        }
                    }
                    .pickerStyle(.inline)
                    .frame(width: 60, height: 100, alignment: .trailing)
                    
                    Text("\(dailyGoal > 1 ? "minutes": "minute")")
                        .animation(.smooth)
                        .frame(width: 80, alignment: .leading)
                }
                .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .presentationDetents([.fraction(0.5)])
            .presentationDragIndicator(.visible)
        }
        
    }
}

#Preview {
    
    ZStack {
        Color.backgroundBlue.ignoresSafeArea()
        GaugeView()
            .preferredColorScheme(.dark)
    }
    .environment(HealthKitData())
    
}
