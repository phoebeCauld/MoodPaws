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
    lazy var calendar = MoodCalendarModel(moods: getCurrentWeek())

    func makeDay(plus days: Int) -> Date {
        var dayComponent    = DateComponents()
        dayComponent.day    = days
        let theCalendar     = Calendar.current
        let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())

        return nextDate ?? Date()
    }

    func getCurrentWeek() -> [MoodCalendarModel.MoodDay] {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        let today = calendar.startOfDay(for: Date())
        let todaysDayOfWeek = calendar.component(.weekday, from: today)

        guard
            let weekdaysRange = calendar.range(of: .weekday, in: .weekOfYear, for: today),
            let index = weekdaysRange.firstIndex(of: calendar.firstWeekday) else {
            return []
        }

        let weekdays = weekdaysRange[index...] + weekdaysRange[..<index].map { $0 + weekdaysRange.count }
        let dates = weekdays.compactMap { calendar.date(byAdding: .day, value: $0 - todaysDayOfWeek, to: today) }
        
        return dates.map { date ->  MoodCalendarModel.MoodDay in
                .init(day: date, moodOfTheDay: .happy)
        }
    }
}
