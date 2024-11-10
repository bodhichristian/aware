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
    
    let columns = 16
    let rows = 7
    
    private var capacity: Int {
        columns * rows
    }

    var body: some View {
        let gridItems = Array(repeating: GridItem(.flexible(), spacing: 4), count: rows)
        
        LazyHGrid(rows: gridItems, spacing: 4) {
            ForEach(GridHelper.gridify(data, with: capacity), id: \.id) { data in
                RoundedRectangle(cornerRadius: 4)
                    .fill(
                        Calendar.current.startOfDay(for: data.date) > Date.now
                        ? .clear
                        : color.progressOpacity(from: data.minutes)
                    )
                    .frame(width: 16, height: 16)
            }
        }
        .padding()
        .frame(height: 180)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.white.opacity(0.5))
        }
    }
}


#Preview {
    HabitGrid(data: MockData.dailyMindfulness(), color: .indigo)
        .preferredColorScheme(.dark)
}
