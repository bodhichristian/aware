//
//  Onboarding.swift
//  Aware
//
//  Created by christian on 11/19/24.
//

import SwiftUI

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
    
    var buttonLabel: String {
        switch self {
        case .name, .goal:
            "Next"
        case .theme:
            "Done"
        }
    }
}

struct Onboarding: View {
    @Binding var onboardingComplete: Bool
    @Environment(AppStyle.self) var style
    @Environment(User.self) var user
    @State private var firstName = ""
    @State private var dailyGoalMinutes = 7
    @State private var selectedPalette: Palette = .green
    @State private var phase: OnboardingPhase = .name
    
    var body: some View {
        NavigationStack {
            ZStack {
                MindfulMeshGradient(engaged: .constant(false))
                
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
            }
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                        .padding(.top)

                }
                ToolbarItem(placement: .topBarTrailing) {
                    advanceButton
                        .padding(.top)
                }
            }
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
                    // keeping the appp running. replace with functionality to add user object
                    onboardingComplete = true
                }
                
            }
        } label: {
            Capsule()
                .foregroundStyle(firstName.isEmpty ? .gray : style.palette.accentColor)
                .frame(width: 108, height: 36)
                .overlay {
                    Text(phase.buttonLabel)
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
                    onboardingComplete = true
                case .goal:
                    phase = .name
                case .theme:
                    // keeping the appp running. replace with functionality to add user object
                    phase = .goal
                }
            }
            
        } label: {
            Capsule()
                .foregroundStyle(.white)
                .frame(width: 108, height: 36)
                .overlay {
                    Text(phase == .name ? "Skip" : "Back")
                        .fontWeight(.medium)
                        .foregroundStyle(style.palette.background)
                }
                .padding(.bottom)
        }
        .disabled(firstName.isEmpty)
    }
    
    private var nameInput: some View {
        VStack {
            Text(phase.prompt)
                .font(.title)
                .fontWeight(.medium)
            
            TextField("First name", text: $firstName)
                .multilineTextAlignment(.center)
                .padding(.bottom)
        }
    }
    private var goalInput: some View {
        VStack {
            Text("What's your daily goal?")
                .font(.title)
                .fontWeight(.medium)
            
            Text("You can change this later in settings.")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            HStack {
                Picker("Daily Goal", selection: $dailyGoalMinutes) {
                    ForEach(1..<61) { minutes in
                        Text(String(minutes))
                        
                    }
                }
                .pickerStyle(.inline)
                .frame(width: 60, alignment: .trailing)
                
                Text("\(dailyGoalMinutes > 1 ? "minutes": "minute")")
                    .animation(.smooth)
                    .frame(width: 80, alignment: .leading)
            }
            .font(.headline)
        }
        
    }
    
    private var themeSelection: some View {
        VStack {
            Text(phase.prompt)
                .font(.title)
                .fontWeight(.medium)
            HStack{
                ThemePreviewTile(palette: .earth)
                    .onTapGesture {
                        style.setEarthTheme()
                    }
                ThemePreviewTile(palette: .green)
                    .onTapGesture {
                        style.setGreenTheme()
                    }
            }
            HStack {
                ThemePreviewTile(palette: .gray)
                    .onTapGesture {
                        style.setGrayTheme()
                    }
                ThemePreviewTile(palette: .indigo)
                    .onTapGesture {
                        style.setIndigoTheme()
                    }
            }
        }
        .padding(.bottom, 24)
    }
}

#Preview {
    Onboarding(onboardingComplete: .constant(false))
        .environment(AppStyle(palette: .green))
        .environment(User(firstName: "", dailyGoalMinutes: 8))
        .preferredColorScheme(.dark)
}
