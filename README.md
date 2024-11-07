# Aware
Bring attention to the moment.

<b>Aware</b> is an iOS app prototype for practicing and tracking mindfulness. Users may start and end a mindfulness session, and have the option to leverage Apple Health for reading and writing mindfulness data.

## Technologies Used
- SwiftUI
- HealthKit
- Swift Algorithms
- DocC

https://github.com/user-attachments/assets/096196e4-c20c-44ad-8e10-2243d6128122

## Discussion
Upon first launch, Aware will leverage HealthKitUI to request permissions from the user. Should the user provide access to reading and writing Health data, they may record new sessions and view historical data.

A progress gauge reminds a user of their goals, and shares their progress. Users may monitor their mindfulness trends with a heat map habit grid, and gain useful insights like last and average session durations.

When in session, the user is presented as few UI elements as possible, and the new MeshGradient API provides a subtle, yet immersive animation. 

## Challenges

### Habit Grid
![Screenshot 2024-11-06 at 7 58 50 PM](https://github.com/user-attachments/assets/3f84a43e-af60-469f-9302-342db5c078b0)

Drawing a grid is straightforward enough. Drawing a grid when you may have more or less data than available cells was a worthy challenge. I broke it down into three stepos.

1. The first step was to collect total minutes of mindfulness by calendar day, and Swift Algorithm's <b>chunked(by:)</b> array method saved the day.
2. Once the data was organized, the second step was to assess whether the count of items will satisfy available positions, and insert placeholder cells when necessary.
3. The final challenge was treating the trailing column of data like it was the current week. This means depending on what day <i>today</i> is for the user, there are 1-6 empty positions that show no cells. To do this, a simple extension of Date converts any day of the week to an integer between 1 and 7. The difference between the total number of days in a week (7) and today's <i>weekday int</i> is the number of positions that are unavailable (in the future, this week). 
