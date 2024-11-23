//
//  MindfulMeshGradient.swift
//  Aware
//
//  Created by christian on 11/4/24.
//

import SwiftUI

struct MindfulMeshGradient: View {
    @Binding var inSession: Bool
    @Environment(Mesh.self) var mesh
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
            colors = style.palette.meshColors
            if mesh.isAnimating {
                startAnimation()
            }
        }
        .onChange(of: style.palette) {
            colors = style.palette.meshColors
        }
        .onChange(of: mesh.isAnimating) {
            if mesh.isAnimating {
                startAnimation()
            } else {
                stopAnimation()
            }
        }
        .onTapGesture {
            withAnimation(.smooth(duration: 1.5)) {
                inSession = false
                mesh.isAnimating = false
                colors = style.palette.meshColors
            }
        }
    }
    
    private func startAnimation() {
        mesh.isAnimating = true
        animateMesh()
    }
    
    private func stopAnimation() {
        mesh.isAnimating = false
    }
    
    private func animateMesh() {
        guard mesh.isAnimating else { return }
        withAnimation(.easeIn(duration: animationDuration)) {
            colors = colors!.shuffled()
        }
        // Schedule next animation only if still animating
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            if mesh.isAnimating {
                animateMesh()
            }
        }
    }
}

#Preview {
    MindfulMeshGradient(inSession: .constant(true))
        .preferredColorScheme(.dark)
        .environment(AppStyle(palette: .green))
}



