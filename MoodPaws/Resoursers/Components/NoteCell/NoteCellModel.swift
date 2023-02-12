import UIKit

struct NoteCellModel {
    let titleText: String
    let titleTextColor: UIColor?
    let titleTextFont: UIFont?
    let noteType: NoteType
    var isNoteСompleted: Bool

    init(
        titleText: String,
        titleTextColor: UIColor? = nil,
        titleTextFont: UIFont? = nil,
        noteType: NoteType,
        isNoteСompleted: Bool = false
    ) {
        self.titleText = titleText
        self.titleTextColor = titleTextColor
        self.titleTextFont = titleTextFont
        self.noteType = noteType
        self.isNoteСompleted = isNoteСompleted
    }

    enum NoteType {
        case grateful
        case mood
        case todayExpectation
        case goodDeeds
        case todayExperience
        case tomorrowExpectation
        case basic
    }
}
