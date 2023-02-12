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

    enum Mood: String {
        case gratitude
        case happy
        case optimistic
        case inLove
        case joy
        case excited
        case anger
        case annoyed
        case anxious
        case sad
        case upset
        case sorrow
        case stressfull
        case calm
        case confused
    
        func getMoodType() -> MoodType{
            switch self {
            case .happy, .inLove, .excited, .optimistic, .joy:
                return .good
            case .anger, .annoyed, .anxious, .sad, .upset, .sorrow, .stressfull:
                return .bad
            case .calm, .gratitude, .confused:
                return .neutral
            }
        }
    }

    enum MoodType {
        case good
        case bad
        case neutral
    }
}
