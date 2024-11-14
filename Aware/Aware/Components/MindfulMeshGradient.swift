//
//  MindfulMeshGradient.swift
//  Aware
//
//  Created by christian on 11/4/24.
//

import SwiftUI

struct MindfulMeshGradient: View {
    @Binding var engaged: Bool
    @Environment(AppStyle.self) var style
    
    @State private var points: [SIMD2<Float>] = [
        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
        [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0],
        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0],
    ]
    
    @State private var colors: [Color]?
    @State private var isAnimating: Bool = false
    
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
            colors = style.theme.meshColors
        }
        .onChange(of: engaged) {
            if engaged {
                startAnimation()
            } else {
                
            }
        }
        .onTapGesture {
            withAnimation(.smooth(duration: 1.5)) {
                engaged = false
                colors = style.theme.meshColors
                stopAnimation()
            }
        }
    }
    
    private func startAnimation() {
        isAnimating = true
        animateMesh()
    }
    
    private func stopAnimation() {
        isAnimating = false
    }
    
    private func animateMesh() {
        guard isAnimating else { return }
        withAnimation(.easeIn(duration: animationDuration)) {
            colors = colors!.shuffled()
        }
        // Schedule next animation only if still animating
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            if isAnimating {
                animateMesh()
            }
        }
    }
}

#Preview {
    MindfulMeshGradient(engaged: .constant(true))
        .preferredColorScheme(.dark)
}



