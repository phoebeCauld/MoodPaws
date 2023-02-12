import Foundation

struct CurrentMoodAddModel {
    let title: TitleLabelModel
    let currentMood: CurrentMood
    let hintText: TextLabelModel
    
    enum CurrentMood {
        case noMood(TextLabelModel)
        case mood(String)
    }
}
