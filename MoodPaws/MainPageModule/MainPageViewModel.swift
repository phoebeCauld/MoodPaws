import Foundation

protocol IMainPageViewModel {
    func didTapOnCell(with type: NoteCellModel.NoteType)
}

final class MainPageViewModel: IMainPageViewModel {

    private var router: IRouter
    private (set) lazy var model = MainPageModel(calendar: .init(moods: getCurrentWeekWithMood()),
                                                 noteView: getNoteModel())

    private let allDaysMoods = CoreDataManager.shared.fetchAllDaysMoods()

    init(
        router: IRouter
    ) {
        self.router = router
    }

    func didTapOnCell(with type: NoteCellModel.NoteType) {

    }

    func getCurrentWeekWithMood() -> [MoodCalendarModel.MoodDay] {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        let today = calendar.startOfDay(for: Date())
        var dates = [Date]()
        if let weekInterval = calendar.dateInterval(of: .weekOfYear, for: today) {
            (0...6).forEach {
                if let day = calendar.date(byAdding: .day, value: $0, to: weekInterval.start) {
                    dates += [day]
                }
            }
        }

        let datesWithMood = dates.map { date -> MoodCalendarModel.MoodDay in
            let dayWithMood = allDaysMoods.first(where: { model in
                guard let day = model.day else { return false }

                return Calendar.current.isDate(day, inSameDayAs: date)
            })
        
            let dateComponents = date.dayAndMonthStringComponents
            let isCurrentDay = Calendar.current.isDateInToday(date)
            return .init(date: dateComponents, isCurrentDay: isCurrentDay, moodOfTheDay: .init(rawValue: dayWithMood?.mood ?? ""))
        }
        return datesWithMood
    }

    private func getNoteModel() -> NoteViewModel {
        let todayMood = CoreDataManager.shared.fetchCurrentDay()

        let noteTime = NoteTime(with: Date())
        switch noteTime {
        case .morning:
            return NoteViewModel.makeMorningModel(with: todayMood)
        case .evening:
            return NoteViewModel.makeEveningModel(with: todayMood)
        }
    }

}
