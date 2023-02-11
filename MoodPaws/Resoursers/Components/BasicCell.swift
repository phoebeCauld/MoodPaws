import UIKit

final class BasicCell: UIView {
    let titleView = UILabel()
    let progressView = UIView()
    let actionIconView = UIImageView()

    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [titleView, progressView, actionIconView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    func configure(with model: BasicCellModel) {
        titleView.text = model.titleText
        titleView.font = model.titleTextFont ?? .systemFont(ofSize: 20)
        titleView.textColor = model.titleTextColor ?? .mpLightPurple
    }
}

struct BasicCellModel {
    let titleText: String
    let titleTextColor: UIColor?
    let titleTextFont: UIFont?

    init(
        titleText: String,
        titleTextColor: UIColor? = nil,
        titleTextFont: UIFont? = nil
    ) {
        self.titleText = titleText
        self.titleTextColor = titleTextColor
        self.titleTextFont = titleTextFont
    }
}
