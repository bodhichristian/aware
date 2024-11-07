//
//  GridHelper.swift
//  Aware
//
//  Created by christian on 11/6/24.
//

import Foundation
import SwiftUI

struct GridHelper {
    /// Make a collection of mindfulness data suitable for a ``HabitGrid`` instance.
    /// - Parameter capacity: Columns x Rows
    /// - Returns: A collection of mindfulness data with any necessary placeholder data
    static func gridify(_ data: [DailyMindfulness], with capacity: Int) -> [DailyMindfulness] {
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
        // Append the provided data to any potentially created placeholders
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
