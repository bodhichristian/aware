//
//  DataTile.swift
//  Aware
//
//  Created by christian on 10/29/24.
//

import SwiftUI

struct DataTile: View {
    @Environment(AppState.self) var appState
    let header: String
    let headerSymbol: String
    let value: Int
    let unit: String
    let radius: CGFloat = 16
    
    var body: some View {
        ZStack(alignment: .top)  {
            // Base
            RoundedRectangle(cornerRadius: radius)
                .foregroundStyle(.ultraThinMaterial)
                .shadow(radius: 4, x: 4)
            // Header
            UnevenRoundedRectangle(
                cornerRadii: RectangleCornerRadii(
                    topLeading: radius,
                    bottomLeading: 0,
                    bottomTrailing: 0,
                    topTrailing: radius
                )
            )
            .frame(maxHeight: 36)
            .foregroundStyle(appState.theme.tileHeader)
            .overlay {
                Text(header)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
            }
            RoundedRectangle(cornerRadius: radius)
                .stroke(appState.theme.accentColor.gradient, lineWidth: 1)
            // Body
            VStack(alignment: .leading)  {
                Text(String(value))
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(appState.theme.accentColor)
                
                Text(unit)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)

            }
            .fontDesign(.rounded)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .bottomLeading
            )
            .padding(8)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
    }
}

#Preview {
    ZStack{
        Color.backgroundBlue.ignoresSafeArea()
        DataTile(
            header: "Today",
            headerSymbol: "calendar",
            value: 7,
            unit: "sessions"
        )
    }
    
}
