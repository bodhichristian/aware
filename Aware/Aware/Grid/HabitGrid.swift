//
//  HeatMap.swift
//  Aware
//
//  Created by christian on 10/28/24.
//

import SwiftUI

struct HabitGrid: View {
    let data: [DailyMindfulness]
    let color: Color
    
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
                        : color.progressOpacity(from: data.minutes)
                    )
                    .aspectRatio(contentMode: .fit)
            }
        }
        .padding()
        .frame(height: 180)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.ultraThinMaterial)
        }
    }
}


#Preview {
    VStack {
        HabitGrid(data: MockData.dailyMindfulness(), color: .indigo)
        HabitGrid(data: MockData.dailyMindfulness(), color: .green)
        HabitGrid(data: MockData.dailyMindfulness(), color: .blue)
        HabitGrid(data: MockData.dailyMindfulness(), color: .pink)

    }
        .preferredColorScheme(.dark)
}
