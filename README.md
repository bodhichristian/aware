# Aware
Bring attention to the moment.
<b>Aware</b> is an iOS app prototype for practicing and tracking mindfulness. Users may start and end a mindfulness session, and have the option to leverage Apple Health for reading and writing mindfulness data.

## Technologies Used
- SwiftUI
- HealthKit
- Swift Algorithms
- DocC

![Promo Images 001](https://github.com/user-attachments/assets/c928a468-f8bb-4fd9-8121-81f6652dd90a)

## Discussion
Upon first launch, Aware will leverage HealthKitUI to request permissions from the user. Should the user provide access to reading and writing Health data, they may record new sessions and view historical data.

A progress gauge reminds a user of their goals, and shares their progress. Users may monitor their mindfulness trends with a heat map habit grid, and gain useful insights like last and average session durations.

When in session, the user is presented as few UI elements as possible, and the new MeshGradient API provides a subtle, yet immersive animation. 

https://github.com/user-attachments/assets/e6c2b8b5-78d8-4e7d-872c-d516226d39dd

## Challenges

### Habit Grid
![Screenshot 2024-11-06 at 7 58 50 PM](https://github.com/user-attachments/assets/3f84a43e-af60-469f-9302-342db5c078b0)

Drawing a grid is straightforward enough. Drawing a grid when you may have more or less data than available cells was a worthy challenge. I broke it down into three steps.

1. The first step was to collect total minutes of mindfulness by calendar day, and Swift Algorithm's <b>chunked(by:)</b> array method saved the day.
2. Once the data was organized, the second step was to assess whether the count of items will satisfy available positions, and insert placeholder cells when necessary.
3. The final challenge was treating the trailing column of data like it was the current week. This means depending on what day <i>today</i> is for the user, there are 1-6 empty positions that show no cells. To do this, a simple extension of Date converts any day of the week to an integer between 1 and 7. The difference between the total number of days in a week (7) and today's <i>weekday int</i> is the number of positions that are unavailable (in the future, this week). 

```swift
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
```
