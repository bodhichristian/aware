# Aware
Bring attention to the moment.  

<b>Aware</b> is an iOS app prototype for practicing and tracking mindfulness. Users may start and end a mindfulness session, and have the option to leverage Apple Health for reading and writing mindfulness data. A simple, skippable onboarding flow allows users to select a daily goal and theme before presenting the main dashboard. The app is accessible to VoiceOver users.

## Technologies Used
- SwiftUI
- HealthKit
- Swift Algorithms
- DocC

![app gallery 008](https://github.com/user-attachments/assets/e04411f1-6ea4-4e55-bdc0-20d104d87319)

## Discussion
Upon first launch, Aware will leverage HealthKitUI to request permissions from the user. Should the user provide access to reading and writing Health data, they may record new sessions and view historical data.

A progress gauge reminds a user of their goals, and shares their progress. Users may monitor their mindfulness trends with a heat map habit grid, and gain useful insights like last and average session durations.

When in session, the user is presented as few UI elements as possible, and the new MeshGradient API provides a subtle, yet immersive animation. 

https://github.com/user-attachments/assets/e6c2b8b5-78d8-4e7d-872c-d516226d39dd

## Challenges

### Habit Grid
![Screenshot 2024-11-06 at 7 58 50 PM](https://github.com/user-attachments/assets/3f84a43e-af60-469f-9302-342db5c078b0)

Drawing a grid is straightforward enough. Drawing a grid when you may have more or less data than available cells was a worthy challenge. I broke it down into three steps.

- <b>Step 1:</b> Gather mindfulness sessions, and group them by calendar day using chunked(by:) from Swift Algorithms.
- <b>Step 2:</b> Assess the difference between days of mindfulness and grid capacity, and insert placeholder cells or cut off extra data as necessary.
- <b>Step 3:</b> Treat the trailing column of data like it is the current week. This means depending on what day <i>today</i> is for the user, there are 1-6 empty positions that show no cells. To do this, a simple extension of Date converts any day of the week to an integer between 1 and 7. The difference between the total number of days in a week (7) and today's <i>weekday int</i> is the number of positions that are unavailable (in the future, this week). 

```swift
struct GridHelper {
    static func gridify(_ data: [DailyMindfulness], with capacity: Int) -> [DailyMindfulness] {
        var gridData: [DailyMindfulness] = []
        let gridCapacity = capacity
        let calendar = Calendar.current
        let todayInt = Date.now.weekdayInt
        let futurePlaceholderCount = 7 - todayInt

        for i in 0..<futurePlaceholderCount {
            let futureDate = calendar.date(byAdding: .day, value: i + 1, to: .now)!
            let placeholder = DailyMindfulness(date: futureDate, minutes: 0)
            gridData.append(placeholder)
        }

        gridData += data

        let gridItemCount = capacity - futurePlaceholderCount
        let difference = gridItemCount - data.count
        if difference > 0 {
            let oldestDate = gridData.first?.date
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
