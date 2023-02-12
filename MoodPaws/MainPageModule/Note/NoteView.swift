import UIKit

final class NoteView: UIView {
    weak var delegate: NoteCellViewDelegate?

    private let componentsFactory: IComponentsFactory
    
    private lazy var titleLabel = componentsFactory.makeTitleLabel()
    private lazy var cellsStackView = componentsFactory.makeBaseStackView()
    
    init(componentsFactory: IComponentsFactory) {
        self.componentsFactory = componentsFactory
        
        super.init(frame: .zero)
        
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
    }

    private func setupView() {
        addSubviews([
            titleLabel,
            cellsStackView,
        ])
        backgroundColor = .white
        roundCorners(corners: .allCorners, radius: 24)
        addShadow()
    }
    
    func configure(with model: NoteViewModel) {
        titleLabel.configure(with: model.titleLabel)

        configureCellsStackView(with: model.noteCells)
    }

    private func configureCellsStackView(with cells: [NoteCellModel]) {
        cellsStackView.configure(spacing: 8)
        cellsStackView.arrangedSubviews.forEach{ cellsStackView.removeArrangedSubview($0) }
        
        let noteCellViews = cells.map { model in
            let cell = componentsFactory.makeBaseCell()
            cell.delegate = delegate
            cell.configure(with: model)
            return cell
        }
        
        cellsStackView.addArrangedSubviews(noteCellViews)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            cellsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            cellsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
