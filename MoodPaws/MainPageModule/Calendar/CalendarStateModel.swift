import Foundation

struct MoodCalendarModel {
    let moods: [MoodDay]
}

extension MoodCalendarModel {
    
    struct MoodDay {
        let date: (weekday: String, day: String)
        let isCurrentDay: Bool
        let moodOfTheDay: Mood?
    }
}
