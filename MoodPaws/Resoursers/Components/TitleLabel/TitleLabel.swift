import UIKit

final class TitleLbel: UILabel {

    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: TitleLabelModel) {
        text = model.title
        textColor = model.textColor ?? .label
        font = model.font ?? .systemFont(ofSize: 30, weight: .bold)
        textAlignment = model.textAlignment ?? .left
    }
}
