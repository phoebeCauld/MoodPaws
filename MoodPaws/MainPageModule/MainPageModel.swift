import Foundation

struct MainPageModel {
    let calendar: MoodCalendarModel
    
    init() {
        var mock = CalendarMock()
        self.calendar = mock.calendar
    }
    

}

struct MoodCalendarModel {
    let moods: [MoodDay]
}

extension MoodCalendarModel {
    struct MoodDay {
        let day: Date
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

struct CalendarMock {
    lazy var calendar = MoodCalendarModel(moods: [
        .init(day: makeDay(plus: -3), moodOfTheDay: .joy),
        .init(day: makeDay(plus: -2), moodOfTheDay: .anger),
        .init(day: makeDay(plus: -1), moodOfTheDay: .stressfull),
        .init(day: makeDay(plus: 0), moodOfTheDay: .inLove),
        .init(day: makeDay(plus: 1), moodOfTheDay: .confused),
        .init(day: makeDay(plus: 2), moodOfTheDay: nil),
        .init(day: makeDay(plus: 3), moodOfTheDay: nil)
    ])

    func makeDay(plus days: Int) -> Date {
        var dayComponent    = DateComponents()
        dayComponent.day    = days
        let theCalendar     = Calendar.current
        let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())

        return nextDate ?? Date()
    }
}
