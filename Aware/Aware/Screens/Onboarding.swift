//
//  Onboarding.swift
//  Aware
//
//  Created by christian on 11/19/24.
//

import SwiftUI

@Observable
class Onboarding {
    var complete = false
    var phase: OnboardingPhase = .name
}


enum OnboardingPhase {
    case name, goal, theme
    
    var prompt: String {
        switch self {
        case .name:
            "What's your name?"
        case .goal:
            "What's your daily goal?"
        case .theme:
            "Select a theme"
        }
    }
    var subtitle: String {
        switch self {
        case .name:
            ""
        case .goal:
            "You can change this later in Settings"
        case .theme:
            "Select a theme to get started."
        }
    }
}

struct OnboardingView: View {
    @Environment(AppStyle.self) var style
    @Environment(Onboarding.self) var onboarding
    @Environment(Mesh.self) var mesh
    @Environment(User.self) var user
    @State private var firstName = ""
    @State private var dailyGoalMinutes = 7
    @State private var selectedPalette: Palette = .green
    @State private var phase: OnboardingPhase = .name
    
    var body: some View {
        NavigationStack {
            ZStack {
                MindfulMeshGradient(inSession: .constant(true))
                
                HStack {
                    backButton
                    VStack {
                        switch phase {
                        case .name:
                            nameInput
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
                case .name:
                    phase = .goal
                case .goal:
                    phase = .theme
                case .theme:
                    exitOnboarding()
                }
            }
        } label: {
            Circle()
                .foregroundStyle(firstName.isEmpty ? .gray : style.palette.accentColor)
                .frame(width: 30)
                .padding()
                .overlay {
                    Image(systemName: "chevron.right")
                        .font(.caption)
//                    Text(phase.buttonLabel)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                }
                .padding(.bottom)
        }
        .disabled(firstName.isEmpty)
    }
    
    
    private var backButton: some View {
        Button {
            withAnimation(.smooth) {
                switch phase {
                case .name:
                    onboarding.complete = true
                    mesh.isAnimating = false
                case .goal:
                    phase = .name
                case .theme:
                    // keeping the appp running. replace with functionality to add user object
                    phase = .goal
                }
            }
            
        } label: {
            Circle()
                .foregroundStyle(.white)
                .frame(width: 30)
                .padding()
                .overlay {
                    Image(systemName: phase == .name ? "xmark" : "chevron.left")
                        .font(.caption)
//                    Text(phase == .name ? "Skip" : "Back")
                        .fontWeight(.medium)
                        .foregroundStyle(style.palette.background)
                }
                .padding(.bottom)
        }
        .disabled(firstName.isEmpty)
    }
    
    private var nameInput: some View {
        VStack {
            Text("Hello.")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(style.palette.accentColor.gradient)
            Text(phase.prompt)
                .multilineTextAlignment(.center)
                .font(.title2)
                .fontWeight(.medium)

            
            TextField("First name", text: $firstName)
                .multilineTextAlignment(.center)
                .padding(.bottom)
                .frame(height: 70, alignment: .top)
                .foregroundStyle(.secondary)
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
                Picker("Daily Goal", selection: $dailyGoalMinutes) {
                    ForEach(1..<61) { minutes in
                        Text(String(minutes))
                        
                    }
                }
                .pickerStyle(.inline)
                .frame(width: 60, height: 100, alignment: .trailing)
                
                Text("\(dailyGoalMinutes > 1 ? "minutes": "minute")")
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
                    .onTapGesture {
                        style.palette = .earth
                    }
                ThemePreviewTile(palette: .green)
                    .onTapGesture {
                        style.palette = .green
                    }
            }
            HStack {
                ThemePreviewTile(palette: .gray)
                    .onTapGesture {
                        style.palette = .gray
                    }
                ThemePreviewTile(palette: .indigo)
                    .onTapGesture {
                        style.palette = .indigo
                    }
            }
        }
        .padding(.bottom, 24)
    }
    
    private func exitOnboarding() {
        onboarding.complete = true
        mesh.isAnimating = false
    }
}

#Preview {
    OnboardingView()
        .environment(AppStyle(palette: .green))
        .environment(User(firstName: "", dailyGoalMinutes: 8))
        .preferredColorScheme(.dark)
}
