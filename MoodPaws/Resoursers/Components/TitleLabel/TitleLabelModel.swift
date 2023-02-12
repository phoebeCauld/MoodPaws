import UIKit

struct TitleLabelModel {
    let title: String
    let textColor: UIColor?
    let font: UIFont?
    let textAlignment: NSTextAlignment?
    
    init(
        title: String,
        textColor: UIColor?,
        font: UIFont? = nil,
        textAlignment: NSTextAlignment? = nil
    ) {
        self.title = title
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
    }
}
