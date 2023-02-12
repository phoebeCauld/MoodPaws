import Foundation

struct MainPageModel {
    let calendar: MoodCalendarModel
    let noteView: NoteViewModel
    let currentMoodAdd: CurrentMoodAddModel
}


enum Mood: String, CaseIterable {
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
