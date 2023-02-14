import Foundation

protocol IMainPageViewModel {
    func didTapOnCell(with type: NoteCellModel.NoteType)
    func goToCurrentMoodCreatorVC()
}

protocol MainPageViewModelDelegate: AnyObject {
    func modelDidRegenerate(viewModel: MainPageViewModel)
}

final class MainPageViewModel: IMainPageViewModel {
    weak var delegate: MainPageViewModelDelegate?

    private var router: IRouter
    private (set) lazy var model = MainPageModel(
        calendar: .init(moods: getCurrentWeekWithMood(from: dataModel?.allDaysMoods)),
        noteView: getNoteModel(for: dataModel?.todayMood),
        currentMoodAdd: getCurrentMoodAddModel(for: dataModel?.todayMood))

    private var dataModel: DataModel? {
        didSet {
            regenerateModel()
        }
    }

    init(router: IRouter) {
        self.router = router

        dataModel = fetchData()
        self.router.delegate = self
    }

    private func fetchData() -> DataModel {
        let allDaysMoods = CoreDataManager.shared.fetchAllDaysMoods()
        let todayMood = CoreDataManager.shared.fetchCurrentDay()
        
        return .init(allDaysMoods: allDaysMoods, todayMood: todayMood)
    }

    private func regenerateModel() {
        let currentWeek = getCurrentWeekWithMood(from: dataModel?.allDaysMoods)
        let noteModel = getNoteModel(for: dataModel?.todayMood)
        let currentMoodModel = getCurrentMoodAddModel(for: dataModel?.todayMood)

        model = MainPageModel(calendar: .init(moods: currentWeek), noteView: noteModel, currentMoodAdd: currentMoodModel)
    }

    private func getCurrentWeekWithMood(from allDaysMoods: [DayMood]?) -> [MoodCalendarModel.MoodDay] {
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
            let dayWithMood = allDaysMoods?.first(where: { model in
                guard let day = model.day else { return false }

                return Calendar.current.isDate(day, inSameDayAs: date)
            })

        // ToDo: Выбирать most common mood
            let moodOfTheDay = dayWithMood?.moods?.lastObject as? String

            let dateComponents = date.dayAndMonthStringComponents
            let isCurrentDay = Calendar.current.isDateInToday(date)
            return .init(date: dateComponents, isCurrentDay: isCurrentDay, moodOfTheDay: .init(rawValue: moodOfTheDay ?? ""))
        }
        return datesWithMood
    }

    private func getNoteModel(for todayMood: DayMood?) -> NoteViewModel {
        let noteTime = NoteTime(with: Date())
        switch noteTime {
        case .morning:
            return NoteViewModel.makeMorningModel(with: todayMood)
        case .evening:
            return NoteViewModel.makeEveningModel(with: todayMood)
        }
    }

    private func getCurrentMoodAddModel(for todayMood: DayMood?) -> CurrentMoodAddModel {
        let currentMood: CurrentMoodAddModel.CurrentMood
        var hintText = TextLabelModel (title: "",
                                       font: .systemFont(ofSize: 14, weight: .semibold),
                                       textAlignment: .center)
        
        if let moodName = todayMood?.moods?.lastObject as? String {
            currentMood = .mood(moodName)
            hintText.title = "If your mood has changed, you can change it"
        } else {
            currentMood = .noMood(.init(title: "You have not added a mood yet",
                                  font: .systemFont(ofSize: 16, weight: .semibold),
                                  textAlignment: .center))
            hintText.title = "Tap to add your mood at the moment"
        }
        return .init(title: .init(title: "Current mood"), currentMood: currentMood, hintText: hintText)
    }

}

// MARK: IMainPageViewModel methods

extension MainPageViewModel {
    func didTapOnCell(with type: NoteCellModel.NoteType) {

    }
    
    func goToCurrentMoodCreatorVC() {
        let lastChoosenMood = Mood(rawValue: dataModel?.todayMood.moods?.lastObject as? String ?? "")
        router.showCurrentMoodCreatorVC(with: .init(moods: Mood.allCases, lastChoosenMood: lastChoosenMood))
    }
}

extension MainPageViewModel: RouterDelegate {
    func refreshViewModel() {
        dataModel = fetchData()
        regenerateModel()
        delegate?.modelDidRegenerate(viewModel: self)
    }
}

struct DataModel {
    let allDaysMoods: [DayMood]
    let todayMood: DayMood
}
