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
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.ultraThinMaterial)
            // Footer
            UnevenRoundedRectangle(
                cornerRadii: RectangleCornerRadii(
                    topLeading: 0,
                    bottomLeading: 16,
                    bottomTrailing: 16,
                    topTrailing: 0
                )
            )
            .frame(maxHeight: 44)
            .foregroundStyle(appState.theme.tileHeader)
            .overlay {
                Label(footer, systemImage: footerSymbol)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white.gradient)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
            }
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
        }
        .frame(maxWidth: .infinity)
        .frame(height: 160)
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
