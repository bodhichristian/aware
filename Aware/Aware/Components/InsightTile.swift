//
//  InfoTile.swift
//  Aware
//
//  Created by christian on 10/29/24.
//

import SwiftUI

struct InsightTile: View {
    @Environment(AppState.self) var appState
    let header: String
    let content: String
    let footer: String
    let footerSymbol: String
    
    var body: some View {
        ZStack(alignment: .bottom)  {
            // Base
            RoundedRectangle(cornerRadius: AppState.cornerRadius)
                .foregroundStyle(.ultraThinMaterial)
                .shadow(radius: 4, x: 4)
            // Body
            VStack(alignment: .leading, spacing: 10) {
                Text(header)
                    .font(.title3)
                    .fontDesign(.rounded)
                    .fontWeight(.medium)
                    .foregroundStyle(appState.theme.accentColor.mix(with: .white, by: 0.5))
                Text(content)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            // Footer
            UnevenRoundedRectangle(
                cornerRadii: RectangleCornerRadii(
                    topLeading: 0,
                    bottomLeading: AppState.cornerRadius,
                    bottomTrailing: AppState.cornerRadius,
                    topTrailing: 0
                )
            )
            .frame(maxHeight: 36)
            .foregroundStyle(appState.theme.tileHeader)
            .overlay {
                Label(footer, systemImage: footerSymbol)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white.gradient)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
            }
            // Cell outline
            RoundedRectangle(cornerRadius: AppState.cornerRadius)
                .stroke(appState.theme.accentColor.gradient, lineWidth: 1)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 160)
        .accessibilityLabel(header + content + "tap to \(footer)")
    }
}

#Preview {
    ZStack{
        Color.backgroundBlue.ignoresSafeArea()
        InsightTile(
            header: "Keep it up",
            content: "You've had more moments of mindfulness this week than last.",
            footer: "View trends",
            footerSymbol: "chart.bar.fill"
        )
    }
    
}
