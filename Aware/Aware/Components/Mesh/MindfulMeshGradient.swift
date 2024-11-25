//
//  MindfulMeshGradient.swift
//  Aware
//
//  Created by christian on 11/4/24.
//

import SwiftUI

struct MindfulMeshGradient: View {
    @Environment(User.self) var user
    @Environment(AppStyle.self) var style
    @Environment(AppState.self) var appState

    @State private var points: [SIMD2<Float>] = [
        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
        [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0],
        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0],
    ]
    
    @State private var colors: [Color]?
    
    private var isAnimating: Bool {
        appState.scene == .inSession ||
        appState.scene == .onboarding
    }
    
    let animationDuration: Double = 4.0
    
    var body: some View {
        ZStack {
            MeshGradient(
                width: 3,
                height: 4,
                points: points,
                colors: colors ?? AWStyle.meshFor(.indigo)
            )
        }
        .ignoresSafeArea()
        .onAppear {
            colors = style.palette.meshColors
            if isAnimating {
                startAnimation()
            }
        }
        .onChange(of: style.palette) {
            colors = style.palette.meshColors
        }
        .onChange(of: appState.scene) {
            if appState.scene == .inSession {
                startAnimation()
            } else {
                stopAnimation()
            }
        }
        .onTapGesture {
            withAnimation(.smooth(duration: 1.5)) {
                if appState.scene == .inSession {
                    appState.scene = .main
                    colors = style.palette.meshColors
                }
            }
        }
    }
    
    private func startAnimation() {
        animateMesh()
    }
    
    private func stopAnimation() {
        appState.scene = .main
//        user.inSession = false
    }
    
    private func animateMesh() {
        guard isAnimating else { return }
        withAnimation(.easeIn(duration: animationDuration)) {
            colors = colors!.shuffled()
        }
        // Schedule next animation only if still animating
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            if appState.scene == .inSession  {
                animateMesh()
            }
        }
    }
}

#Preview {
    MindfulMeshGradient()
        .preferredColorScheme(.dark)
        .environment(AppStyle(palette: .green))
}



