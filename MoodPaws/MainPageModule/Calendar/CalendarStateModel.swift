import Foundation

struct CalendarStateModel {
    let moods: [CalendarState]

    struct CalendarState {
        let date: (weekday: String, day: String)
        let isCurrentDay: Bool
        let moodOfTheDay: MoodCalendarModel.Mood?
    }
}
