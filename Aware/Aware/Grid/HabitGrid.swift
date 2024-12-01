//
//  HeatMap.swift
//  Aware
//
//  Created by christian on 10/28/24.
//

import SwiftUI

struct HabitGrid: View {
    @Environment(AppState.self) var appState

    let data: [DailyMindfulness]
    
    let columns: Int = 16
    let rows: Int = 7
    let spacing: CGFloat = 4
    
    private var capacity: Int {
        columns * rows
    }
    
    private var gridItems: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: spacing), count: rows)
    }

    var body: some View {
        LazyHGrid(rows: gridItems, spacing: 4) {
            ForEach(GridHelper.gridify(data, with: capacity), id: \.id) { data in
                RoundedRectangle(cornerRadius: 4)
                    .fill(
                        Calendar.current.startOfDay(for: data.date) > Date.now
                        ? .clear
                        : appState.theme.accentColor.progressOpacity(from: data.minutes)
                    )
                    .aspectRatio(contentMode: .fit)
            }
        }
        .padding()
        .frame(height: 180)
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: AppState.cornerRadius)
                    .foregroundStyle(.ultraThinMaterial)
                
                RoundedRectangle(cornerRadius: AppState.cornerRadius)
                    .stroke(appState.theme.accentColor.gradient, lineWidth: 1)
                
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Historical data. Tap to view more.")
    }
}


#Preview {
    VStack {
        HabitGrid(data: MockData.dailyMindfulness())
            .environment(AppState())

    }
        .preferredColorScheme(.dark)
}
