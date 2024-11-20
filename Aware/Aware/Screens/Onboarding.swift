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
    @Environment(AppStyle.self) var style
    @State private var firstName = ""
    @State private var dailyGoalMinutes = 7
    @State private var phase: OnboardingPhase = .name
    
    var body: some View {
        NavigationStack {
            ZStack {
                MindfulMeshGradient(engaged: .constant(false))
                
                switch phase {
                case .name:
                    nameInput
                case .goal:
                    goalInput
                case .theme:
                    themeSelection
                }
                
            }
            .safeAreaInset(edge: .bottom) {
                advanceButton
            }
        }
    }
    
    private var advanceButton: some View {
        Button {
            switch phase {
            case .name:
                phase = .goal
            case .goal:
                phase = .theme
            case .theme:
                // keeping the appp running. replace with functionality to add user object
                phase = .theme
            }
        } label: {
            Capsule()
                .foregroundStyle(style.palette.accentColor)
                .frame(width: 200, height: 44)
                .overlay {
                    Text(phase.buttonLabel)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                }
                .padding(.bottom)
        }
        .disabled(firstName.isEmpty)
    }
    
    private var nameInput: some View {
        ZStack {
            VStack {
                Text(phase.prompt)
                    .font(.title2)
                    .fontWeight(.medium)
                
                
                TextField("First name", text: $firstName)
                    .multilineTextAlignment(.center)
                
            }

        }
        
    }
    private var goalInput: some View {
        ZStack {
            VStack {
                Text("What's your daily goal?")
                    .font(.title2)
                    .fontWeight(.medium)
                
                
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
                        .frame(minWidth: 50, maxWidth: .infinity, alignment: .leading)
                }
                .frame(width: 100)
            }
        }
    }
    private var themeSelection: some View {
        Text("Hi")
    }
}

#Preview {
    Onboarding()
        .environment(AppStyle(palette: .green))
        .preferredColorScheme(.dark)
}
