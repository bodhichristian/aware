//
//  GaugeView.swift
//  Aware
//
//  Created by christian on 10/29/24.
//

import SwiftUI

struct GaugeView: View {
    @Binding var engaged: Bool
    let progress = 0.8
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(engaged ? 0.0 : 0.3)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round))
                .foregroundStyle(AWStyle.minimalGradient(for: .accentPurple))
                .rotationEffect(Angle(degrees: 270.0))
                

            if !engaged {
                VStack {
                    Text("Daily Goal")
                        .font(.title)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .transition(.blurReplace())
                    Text("10 min")
                        .font(.headline)
                        .foregroundStyle(.accentPurple)

                    Button {
                        withAnimation(.smooth(duration: 1)){
                            engaged.toggle()
                        }
                    } label: {
                        
                        Text("Start session")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                            .padding()
                            .background {
                                Capsule()
                                    .foregroundStyle(.white.opacity(0.5))
                                    .frame(height: 44)
                            }
                    }
                    
                }
                .offset(y: 10)
                
            }
        }
        .padding(30)
        .frame(maxWidth: 320, maxHeight: 320)
    }
}

#Preview {
    
    GaugeView(engaged: .constant(true))
        .preferredColorScheme(.dark)
}
