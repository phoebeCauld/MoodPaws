import UIKit

struct ActionButtonModel {
    let title: String
    let textSize: CGFloat
    let textWeight: UIFont.Weight
    let foregroundColor: UIColor
    let backgroundColor: UIColor
    let cornerRadius: CGFloat
    
    init(title: String,
         textSize: CGFloat = 25,
         textWeight: UIFont.Weight = .semibold,
         foregroundColor: UIColor = .white,
         backgroundColor: UIColor = .mpDarkPurple,
         cornerRadius: CGFloat = 20
    ) {
        self.title = title
        self.textSize = textSize
        self.textWeight = textWeight
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
    }
}
