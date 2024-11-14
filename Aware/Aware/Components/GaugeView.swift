//
//  GaugeView.swift
//  Aware
//
//  Created by christian on 10/29/24.
//

import SwiftUI

struct GaugeView: View {
    @Binding var inSession: Bool
    @Environment(HealthKitData.self) var hkData

    private var progress: Double {
        let goal = 10.0
        let todaysMindfulMinutes = Double(hkData.totalMinutesToday())
        let progressRatio = todaysMindfulMinutes / goal
        if progressRatio > 0 {
            return progressRatio
        } else {
            return 0.02 // Ensures progress indication always exists
        }
    }
    
    private var gradient: LinearGradient {
        LinearGradient(
            colors: [.accentSage, .white],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 40.0)
                .foregroundStyle(.backgroundGreen.mix(with: .black, by: 0.1).gradient)
            Circle()
                .stroke(lineWidth: 20.0)
                .foregroundStyle(.backgroundGreen)
            Circle()
                .trim(from: 0.0, to: 0.8)
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round))
                .foregroundStyle(gradient)
                .rotationEffect(Angle(degrees: 270.0))
            VStack {
                Text("Daily Goal")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .transition(.blurReplace())
                Text("10 min")
                    .font(.headline)
                    .foregroundStyle(.accentSage.gradient)
                Button {
                    withAnimation(.smooth(duration: 1)){
                        inSession.toggle()
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
        .shadow(radius: 4)
        .padding(30)
        .frame(maxWidth: 320, maxHeight: 320)
    }
}

#Preview {
    
    ZStack {
        Color.backgroundBlue.ignoresSafeArea()
        GaugeView(inSession: .constant(false))
            .preferredColorScheme(.dark)
    }
    .environment(HealthKitData())

}
