//
//  ThemePreviewTile.swift
//  Aware
//
//  Created by christian on 11/21/24.
//

import SwiftUI

struct ThemePreviewTile: View {
    let palette: Palette
    
    var body: some View {
        ZStack(alignment: .top)  {
            // Base
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(palette.tileBody)
            // Header
            UnevenRoundedRectangle(
                cornerRadii: RectangleCornerRadii(
                    topLeading: 16,
                    bottomLeading: 0,
                    bottomTrailing: 0,
                    topTrailing: 16
                )
            )
            .frame(maxHeight: 36)
            .foregroundStyle(palette.tileHeader)
        }
        .frame(width: 120, height: 90)
    }
}

#Preview {
    
    VStack {
        HStack{
            ThemePreviewTile(palette: .earth)
            ThemePreviewTile(palette: .green)
        }
        HStack {
            ThemePreviewTile(palette: .gray)
            ThemePreviewTile(palette: .indigo)
        }
    }
}