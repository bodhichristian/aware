//
//  MindfulMeshGradient.swift
//  Aware
//
//  Created by christian on 11/4/24.
//

import SwiftUI

struct MindfulMeshGradient: View {
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
            setMeshColorsDefaultOrder()
            if isAnimating {
                startAnimation()
            }
        }
        .onChange(of: appState.theme) {
            setMeshColorsDefaultOrder()
        }
        .onChange(of: appState.scene) {
            if appState.scene == .inSession {
                startAnimation()
            } else {
                setMeshColorsDefaultOrder()
            }
        }
        .onTapGesture {
            if appState.scene == .inSession {
                withAnimation(.smooth(duration: 1.5)) {
                    appState.scene = .main
                    setMeshColorsDefaultOrder()
                }
            }
        }
    }
    
    private func startAnimation() {
        animateMesh()
    }
    
    private func setMeshColorsDefaultOrder() {
        withAnimation {
            colors = appState.theme.meshColors
        }
    }
    
    private func animateMesh() {
        guard isAnimating else { return }
        withAnimation(.easeIn(duration: animationDuration)) {
            colors = colors!.shuffled()
        }
        // Schedule next animation only if still animating
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            if isAnimating  {
                animateMesh()
            }
        }
    }
}

#Preview {
    MindfulMeshGradient()
        .preferredColorScheme(.dark)
        .environment(AppState())
}



