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
            ForEach(gridify(data, with: capacity), id: \.id) { data in
                RoundedRectangle(cornerRadius: 4)
                    .fill(
                        Calendar.current.startOfDay(for: data.date) > Date.now ? .clear :
                        colorForMinutes(data.minutes)
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(1, contentMode: .fit)
            }
        }
        .padding()
        
        .frame(maxWidth: .infinity, minHeight: 180)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.white.opacity(0.5))
        }
    }
    
    // Time-based opacity
    private func colorForMinutes(_ minutes: Int) -> Color {
        if minutes >= 15 {
            return color
        } else if minutes >= 10 {
            return color.opacity(0.7)
        } else if minutes >= 5 {
            return color.opacity(0.3)
        } else {
            return .white.opacity(0.1)
        }
    }
    
    /// Make a collection of mindfulness data suitable for a ``HeatMap`` instance.
    /// - Parameter capacity: Columns x Rows
    /// - Returns: A collection of mindfulness data with any necessary placeholder data
    private func gridify(_ data: [DailyMindfulness], with capacity: Int) -> [DailyMindfulness] {
        // Create an array of data for visualization
        var gridData: [DailyMindfulness] = []
        // Calculate the number of potential grid positions
        let gridCapacity = capacity
        // Get the user's calendar
        let calendar = Calendar.current
        // Calculate Int for the current day of the week
        let todayInt = Date.now.weekdayInt
        // Calculate potential future placeholders
        let futurePlaceholderCount = 7 - todayInt
        // Loop through placeholders and add empty data
        for i in 0..<futurePlaceholderCount {
            let futureDate = calendar.date(byAdding: .day, value: i + 1, to: .now)!
            let placeholder = DailyMindfulness(date: futureDate, minutes: 0)
            gridData.append(placeholder)
        }
        
        gridData += data
        
        // Calculate total number of grid items to draw
        let gridItemCount = capacity - futurePlaceholderCount
        // Calculate potential difference in available data and gridItemCount
        let difference = gridItemCount - data.count
        // Append filler data to complete grid
        if difference > 0 {
            // Get the oldest date in the data set
            let oldestDate = gridData.first?.date
            // Add necessary placeholder data to history
            for i in 0..<difference {
                let fillerDate = calendar.date(byAdding: .day, value: -(i + 1), to: oldestDate ?? .now)!
                let fillerDailyMindfulness = DailyMindfulness(date: fillerDate, minutes: 0)
                gridData.append(fillerDailyMindfulness)
            }
        }
        
        return gridData.prefix(gridCapacity).reversed()
    }
}


#Preview {
    HabitGrid(data: MockData.dailyMindfulness(), color: .indigo)
}
