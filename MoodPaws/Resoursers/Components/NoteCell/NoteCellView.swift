import UIKit

protocol NoteCellViewDelegate: AnyObject {
    func didTapOnCell(_ cell: NoteCellView, withType type: NoteCellModel.NoteType)
}

final class NoteCellView: UIView {
    weak var delegate: NoteCellViewDelegate?

    private let titleView = UILabel()
    private let progressView = UIView()
    private let actionIconView = UIImageView()
    private var cellType: NoteCellModel.NoteType?

    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
    }
    
    private func setupView() {
        [titleView, progressView, actionIconView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        progressView.roundCorners(corners: .allCorners, radius: 2.5)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnCell)))
    }

    func configure(with model: NoteCellModel) {
        cellType = model.noteType
        titleView.text = model.titleText
        titleView.font = model.titleTextFont ?? .systemFont(ofSize: 20)
        titleView.textColor = model.titleTextColor ?? .mpDarkPurple
        
        actionIconView.image = .init(systemName: "chevron.right")
        actionIconView.contentMode = .scaleAspectFit
        actionIconView.tintColor = .mpDarkPurple

        progressView.backgroundColor = model.isNoteСompleted ? .mpLightGreen : .mpLightGray
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: topAnchor, constant: .margin),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .margin),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.margin),
            progressView.widthAnchor.constraint(equalToConstant: .progressViewWidth),
            
            actionIconView.topAnchor.constraint(equalTo: topAnchor, constant: .margin),
            actionIconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.margin),
            actionIconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.margin),
            
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: .margin),
            titleView.leadingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: .margin),
            titleView.trailingAnchor.constraint(equalTo: actionIconView.leadingAnchor, constant: -.margin),
            titleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.margin),
        ])
    }

    @objc
    private func didTapOnCell() {
        delegate?.didTapOnCell(self, withType: cellType ?? .basic)
    }
}

private extension CGFloat {
    static let margin: Self = 16
    static let progressViewWidth: Self = 5
}
