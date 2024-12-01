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
    
    var body: some View {
        ZStack(alignment: .top)  {
            // Base
            RoundedRectangle(cornerRadius: AppState.cornerRadius)
                .foregroundStyle(.ultraThinMaterial)
                .shadow(radius: 4, x: 4)
            // Header
            UnevenRoundedRectangle(
                cornerRadii: RectangleCornerRadii(
                    topLeading: AppState.cornerRadius,
                    bottomLeading: 0,
                    bottomTrailing: 0,
                    topTrailing: AppState.cornerRadius
                )
            )
            .frame(maxHeight: 36)
            .foregroundStyle(appState.theme.tileHeader)
            
            Text(header)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 12)
                .padding(.leading, 8)
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
            // Cell outline
            RoundedRectangle(cornerRadius: AppState.cornerRadius)
                .stroke(appState.theme.accentColor.gradient, lineWidth: 1)
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
