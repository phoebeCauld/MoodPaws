import Foundation

protocol IMainPageViewModel {
    
}

final class MainPageViewModel: IMainPageViewModel {
    private (set) lazy var state = MainPageViewState(
        calendar: .init(
            moods: model.calendar.moods.map({ mood -> CalendarStateModel.CalendarState in
                let date = self.getDateString(from: mood.day)
                let isCurrentDay = Calendar.current.isDateInToday(mood.day)
                return .init(date: date, isCurrentDay: isCurrentDay, moodOfTheDay: mood.moodOfTheDay)
            })
        )
    )

    private var router: IRouter
    private var model: MainPageModel

    init(
        router: IRouter,
        model: MainPageModel
    ) {
        self.router = router
        self.model = model
    }

    private func getDateString(from date: Date) -> (String, String) {
        (DateFormatter.weekdayDateFormatter.string(from: date),
         DateFormatter.onlyDayDateFormatter.string(from: date))
    }

}

struct MainPageViewState {
    let calendar: CalendarStateModel
}
