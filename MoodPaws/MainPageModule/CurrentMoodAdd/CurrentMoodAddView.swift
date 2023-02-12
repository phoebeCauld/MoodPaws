import UIKit

protocol CurrentMoodAddViewDelegate: AnyObject {
    func goToCurrentMoodCreatorView(_ view: CurrentMoodAddView)
}

final class CurrentMoodAddView: UIView {
    weak var delegate: CurrentMoodAddViewDelegate?
    private let componentsFactory: IComponentsFactory
    
    private lazy var titleLabel = componentsFactory.makeCommonTextLabel()
    private lazy var moodsStackView = componentsFactory.makeBaseStackView()
    private let currentMoodImageView = UIImageView()
    private lazy var noCurrentMoodLabel = componentsFactory.makeCommonTextLabel()
    private lazy var hintText = componentsFactory.makeCommonTextLabel()
    
    init(componentsFactory: IComponentsFactory) {
        self.componentsFactory = componentsFactory
        
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

    func configureView(with model: CurrentMoodAddModel) {
        titleLabel.configure(with: model.title)
        titleLabel.textColor = .mpDarkPurple
        configureCurrentMoodView(with: model.currentMood)
        hintText.configure(with: model.hintText)
        hintText.textColor = .mpLightPurple
    }

    func configureCurrentMoodView(with currentMood: CurrentMoodAddModel.CurrentMood) {
        switch currentMood {
        case .noMood(let noCurrentMoodTextModel):
            moodsStackView.isHidden = true
            noCurrentMoodLabel.isHidden = false
            noCurrentMoodLabel.configure(with: noCurrentMoodTextModel)
            noCurrentMoodLabel.textColor = .mpLightPurple
        case .mood(let moodName):
            moodsStackView.isHidden = false
            noCurrentMoodLabel.isHidden = true
            configureCurrentMoodStackView(with: moodName)
        }
    }

    private func configureCurrentMoodStackView(with moodName: String) {
        moodsStackView.arrangedSubviews.forEach { moodsStackView.removeArrangedSubview($0) }

        let moodsArray = Mood.allCases.map { $0.rawValue }.filter{ $0 != moodName }
        
        var moodsImagesArray: [UIImageView] = []
        moodsImagesArray.append(contentsOf: moodsArray.dropFirst(moodsArray.count - 4).map { name -> UIImageView in
            let imageView = UIImageView()
            imageView.image = .init(named: name)?.alpha(0.4)
            imageView.contentMode = .scaleAspectFit
            return imageView
        })
        currentMoodImageView.image = .init(named: moodName)
        moodsImagesArray.insert(currentMoodImageView, at: moodsImagesArray.count/2)
        
        moodsStackView.addArrangedSubviews(moodsImagesArray)
    }

    private func setupView() {
        addSubviews([
            titleLabel,
            moodsStackView,
            noCurrentMoodLabel,
            hintText,
        ])
        
        backgroundColor = .white
        roundCorners(corners: .allCorners, radius: 24)
        addShadow()

        currentMoodImageView.contentMode = .scaleAspectFit
        moodsStackView.configure(axis: .horizontal, spacing: 10)
        moodsStackView.distribution = .fillProportionally
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnCurrentMood)))
    }

    private func setupConstraints() {
        let currentMoodView = moodsStackView.isHidden ? noCurrentMoodLabel : moodsStackView
        
        if !moodsStackView.isHidden {
            guard let middleIndex = moodsStackView.arrangedSubviews.middleIndex else { return }
            let theBiggestWidth: CGFloat = 50
            moodsStackView.arrangedSubviews.enumerated().forEach { index, view in
                let diffrence = CGFloat(abs(middleIndex - index)*15)
                let widthForView: CGFloat = theBiggestWidth - (diffrence == 0 ? -30 : diffrence)
                view.widthAnchor.constraint(equalToConstant: widthForView).isActive = true
            }
            
            currentMoodImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            currentMoodView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            currentMoodView.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentMoodView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, constant: -32),
            
            hintText.topAnchor.constraint(equalTo: currentMoodView.bottomAnchor, constant: 12),
            hintText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            hintText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            hintText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])

    }

    @objc
    private func didTapOnCurrentMood() {
        delegate?.goToCurrentMoodCreatorView(self)
    }
}

extension Array {
    var middleIndex: Int? {
        guard count != 0 else { return nil }

        return (count > 1 ? count - 1 : count) / 2
    }
}
