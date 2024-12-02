//
//  Onboarding.swift
//  Aware
//
//  Created by christian on 11/19/24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(AppState.self) var appState
    @State private var firstName = ""
    @State private var selectedPalette: Palette = .green
    @State private var phase: OnboardingPhase = .goal
    @AppStorage("hasOnboarded") var hasOnboarded: Bool = false
    @AppStorage("dailyGoal") var dailyGoal: Int = 7
    
    var body: some View {
        NavigationStack {
            ZStack {
                MindfulMeshGradient()
                
                HStack {
                    backButton
                    VStack {
                        switch phase {
                        case .goal:
                            goalInput
                        case .theme:
                            themeSelection
                        }
                    }
                    advanceButton
                }
            }
            .ignoresSafeArea()
        }
    }
    
    private var advanceButton: some View {
        Button {
            withAnimation(.smooth) {
                switch phase {
                case .goal:
                    appState.dailyGoal = dailyGoal
                    phase = .theme
                case .theme:
                    exitOnboarding()
                }
            }
        } label: {
            Circle()
                .foregroundStyle(appState.theme.accentColor)
                .frame(width: 30)
                .padding()
                .overlay {
                    Image(systemName: phase == .theme ? "checkmark" : "chevron.right")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                }
                .padding(.bottom)
                .accessibilityLabel(phase.advanceButtonAccessibilityLabel)
        }
    }
    
    private var backButton: some View {
        Button {
            withAnimation(.smooth) {
                switch phase {
                case .goal:
                    exitOnboarding()
                case .theme:
                    phase = .goal
                }
            }
            
        } label: {
            Circle()
                .foregroundStyle(.white)
                .frame(width: 30)
                .padding()
                .overlay {
                    Image(systemName: phase == .goal ? "xmark" : "chevron.left")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(appState.theme.background)
                }
                .padding(.bottom)
                .accessibilityLabel(phase.backButtonAccessibilityLabel)
        }
    }
    
    private var goalInput: some View {
        VStack {
            Text("What's your daily goal?")
                .font(.title2)
                .fontWeight(.medium)
            
            Text(phase.subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            HStack {
                Picker("Daily Goal", selection: $dailyGoal) {
                    ForEach(0..<61) { minutes in
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
    }
    
    private var themeSelection: some View {
        VStack {
            Text(phase.prompt)
                .font(.title2)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
            HStack{
                ThemePreviewTile(palette: .earth)
                    .accessibilityLabel("Select earth theme")
                    .onTapGesture {
                        withAnimation {
                            appState.theme = .earth
                        }
                    }
                ThemePreviewTile(palette: .green)
                    .accessibilityLabel("Select green theme")
                    .onTapGesture {
                        withAnimation {
                            appState.theme = .green
                        }
                    }
            }
            HStack {
                ThemePreviewTile(palette: .gray)
                    .accessibilityLabel("Select gray theme")
                    .onTapGesture {
                        withAnimation {
                            appState.theme = .gray
                        }
                    }
                ThemePreviewTile(palette: .indigo)
                    .accessibilityLabel("Select indigo theme")
                    .onTapGesture {
                        withAnimation {
                            appState.theme = .indigo
                        }
                    }
            }
        }
        .padding(.bottom, 24)
    }
    
    private func exitOnboarding() {
        withAnimation {
            hasOnboarded = true
            appState.scene = .main
        }
    }
}

#Preview {
    OnboardingView()
        .environment(AppState())
        .preferredColorScheme(.dark)
}
