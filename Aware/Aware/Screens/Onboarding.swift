//
//  Onboarding.swift
//  Aware
//
//  Created by christian on 11/19/24.
//

import SwiftUI

enum OnboardingPhase {
    case name, goal, theme
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
        }
    }
    
    private var nameInput: some View {
        ZStack {
            VStack {
                Text("What's your name?")
                    .font(.title2)
                    .fontWeight(.medium)
                    

                TextField("First name", text: $firstName)
                    .multilineTextAlignment(.center)

            }
            if !firstName.isEmpty {
                Button {
                    phase = .goal
                } label: {
                    Capsule()
                        .foregroundStyle(style.palette.accentColor)
                        .frame(width: 200, height: 44)
                        .overlay {
                            Text("Next")
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        }
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(.bottom)
                }
            }
        }

    }
    private var goalInput: some View {
        Text("Hi")
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
