import Foundation

protocol ICurrentMoodCreatorViewModel {
    func saveNewCurrentMoodAndDismiss(_ mood: String)
}

final class CurrentMoodCreatorViewModel: ICurrentMoodCreatorViewModel {
    var state: CurrentMoodCreatorState {
        .init(title: .init(title: "Swipe to chose your mood",
                           textColor: .mpDarkPurple,
                           font: .systemFont(ofSize: 20),
                           textAlignment: .center),
              moods: model.moods,
              lastChoosenMood: model.lastChoosenMood)
    }

    private let model: CurrentMoodCreatorModel
    private var router: IRouter

    init(router: IRouter, model: CurrentMoodCreatorModel) {
        self.router = router
        self.model = model
    }

    func saveNewCurrentMoodAndDismiss(_ mood: String) {
        let todayMoodModel = CoreDataManager.shared.fetchCurrentDay()
        var moods =  todayMoodModel.value(forKey: "moods") as? [String] ?? [String]()
        moods.append(mood)
        todayMoodModel.setValue(moods, forKey: "moods")
        CoreDataManager.shared.saveData()
        router.dismissAndRefreshTopViewController()
    }
}

struct CurrentMoodCreatorModel {
    let moods: [Mood]
    let lastChoosenMood: Mood?
}

struct CurrentMoodCreatorState {
    let title: TitleLabelModel
    let moods: [Mood]
    let lastChoosenMood: Mood?
}
