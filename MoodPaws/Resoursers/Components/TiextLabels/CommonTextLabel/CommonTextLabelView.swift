import UIKit

final class CommonTextLabelView: UILabel {

    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: ICommonTextLabel) {
        text = model.title
        textColor = model.textColor
        font = model.font
        textAlignment = model.textAlignment
    }
}
