//
//  DataTile.swift
//  Aware
//
//  Created by christian on 10/29/24.
//

import SwiftUI

struct DataTile: View {
    @Environment(AppStyle.self) var style
    let header: String
    let headerSymbol: String
    let statString: String
    let bodySymbol: String
    
    var body: some View {
        ZStack(alignment: .top)  {
            // Base
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(style.palette.tileBody)
            // Header
            UnevenRoundedRectangle(
                cornerRadii: RectangleCornerRadii(
                    topLeading: 16,
                    bottomLeading: 0,
                    bottomTrailing: 0,
                    topTrailing: 16
                )
            )
            .frame(maxHeight: 44)
            .foregroundStyle(style.palette.tileHeader)
            .overlay {
                Label(header, systemImage: headerSymbol)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white.opacity(0.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
            }
            // Body
            HStack {
                Text(statString)
                    .font(.title)
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                Spacer()
                
                Image(systemName: bodySymbol)
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .bottomLeading
            )
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 110)
    }
}

#Preview {
    ZStack{
        Color.backgroundBlue.ignoresSafeArea()
        DataTile(
            header: "Last Session",
            headerSymbol: "brain.head.profile",
            statString: "8 min",
            bodySymbol: "gauge.medium"
        )
    }
    
}
