import UIKit

struct TitleLabelModel: ICommonTextLabel {
    var title: String
    var textColor: UIColor
    var font: UIFont
    var textAlignment: NSTextAlignment
    
    init(
        title: String,
        textColor: UIColor = .label,
        font: UIFont = .systemFont(ofSize: 30, weight: .bold),
        textAlignment: NSTextAlignment = .left
    ) {
        self.title = title
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
    }
}
