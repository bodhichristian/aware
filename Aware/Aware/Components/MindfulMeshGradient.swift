//
//  MindfulMeshGradient.swift
//  Aware
//
//  Created by christian on 11/4/24.
//

import SwiftUI

struct MindfulMeshGradient: View {
    @Binding var engaged: Bool
    
    @State private var points: [SIMD2<Float>] = [
        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
        [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0],
        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0],
    ]
    
    @State private var colors: [Color] = AWStyle.defaultMesh()
    @State private var isAnimating: Bool = false
    
    let animationDuration: Double = 4.0
    
    var body: some View {
        ZStack {
            MeshGradient(
                width: 3,
                height: 4,
                points: points,
                colors: colors
            )
            
            if engaged {
                ZStack  {
                    VStack {
                        Text("Bring attention to the moment.")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .transition(.blurReplace)
                        
                       Text("Tap anywhere to end the session.")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        
                    }
                    
                    SessionTimer(inSession: $engaged)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding()
                }
            }
        }
        .ignoresSafeArea()
        .onChange(of: engaged) { oldValue, newValue in
            if newValue {
                startAnimation()
            } else {
                stopAnimation()
            }
        }
        .onTapGesture {
            withAnimation(.smooth(duration: 1.2)) {
                stopAnimation()
                colors = AWStyle.defaultMesh()
                engaged = false
            }
        }
    }
    
    private func startAnimation() {
        isAnimating = true
        animateColors()
    }
    
    private func stopAnimation() {
        isAnimating = false
    }
    
    private func animateColors() {
        guard isAnimating else { return }
        
        withAnimation(.easeIn(duration: animationDuration)) {
            colors = colors.shuffled()
        }
        
        // Schedule next animation only if still animating
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            if isAnimating {
                animateColors()
            }
        }
    }
}

#Preview {
    MindfulMeshGradient(engaged: .constant(true))
        .preferredColorScheme(.dark)
}



