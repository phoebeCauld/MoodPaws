import Foundation

struct NoteViewModel {
    let titleLabel: TitleLabelModel
    let noteCells: [NoteCellModel]

    init(titleLabel: TitleLabelModel, noteCells: [NoteCellModel]) {
        self.titleLabel = titleLabel
        self.noteCells = noteCells
    }

    static func makeMorningModel(with moodModel: DayMood?) -> Self {
        let titleLabel = TitleLabelModel(title: "Morning routine", textColor: .mpDarkPurple)
        let gratefulСell = NoteCellModel(
            titleText: "Grateful",
            noteType: .grateful,
            isNoteСompleted: moodModel?.morningRoutine?.gratefull?.isFilled ?? false)
        let moodCell = NoteCellModel(
            titleText: "Write what you feel now",
            noteType: .mood,
            isNoteСompleted: moodModel?.morningRoutine?.moodAndThoughts?.isFilled ?? false)
        let todayExpectationCell = NoteCellModel(
            titleText: "Today's expectations",
            noteType: .todayExpectation,
            isNoteСompleted: moodModel?.morningRoutine?.todayExpectation?.isFilled ?? false)
        
        return .init(titleLabel: titleLabel, noteCells: [gratefulСell, moodCell, todayExpectationCell])
    }

    static func makeEveningModel(with moodModel: DayMood?) -> Self {
        let titleLabel = TitleLabelModel(title: "Evening routine", textColor: .mpDarkPurple)
        let goodDeedsСell = NoteCellModel(
            titleText: "Good deeds",
            noteType: .goodDeeds,
            isNoteСompleted: moodModel?.eveningRoutine?.goodDeeds?.isFilled ?? false)
        let todayExperienceCell = NoteCellModel(
            titleText: "Today's great experience",
            noteType: .todayExperience,
            isNoteСompleted: moodModel?.eveningRoutine?.todayExperience?.isFilled ?? false)
        let tomorrowExpectationCell = NoteCellModel(
            titleText: "What about tomorrow?",
            noteType: .tomorrowExpectation,
            isNoteСompleted: moodModel?.eveningRoutine?.tomorrowExpectation?.isFilled ?? false)
        
        return .init(titleLabel: titleLabel,
                     noteCells: [goodDeedsСell, todayExperienceCell, tomorrowExpectationCell])
    }
}

enum NoteTime {
    case morning
    case evening
    
    init(with nowDate: Date) {
        guard nowDate.isInMorningRange else {
            self = .evening
            return
        }
    
        self = .morning
    }
}

private extension Date {
    var isInMorningRange: Bool {
        let range = dateAt(hours: 0, minutes: 0)...dateAt(hours: 15, minutes: 0)
        return range.contains(self)
    }
    
    var isInEveningRange: Bool  {
        let range = dateAt(hours: 15, minutes: 0)...dateAt(hours: 24, minutes: 0)
        return range.contains(self)
    }
    
    private func dateAt(hours: Int, minutes: Int) -> Self {
        let calendar = Calendar.current
        
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        
        dateComponents.hour = hours
        dateComponents.minute = minutes
        dateComponents.second = 0
        
        let newDate = calendar.date(from: dateComponents)!
        return newDate
    }
}
