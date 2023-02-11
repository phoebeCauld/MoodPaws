import UIKit

final class DayView: UIView {
    private var componentsFactory: IComponentsFactory

    private let weekDayLabel = UILabel()
    private let dayLabel = UILabel()
    private let moodView = UIImageView()
    
    private lazy var dayStackView = componentsFactory.makeBaseStackView()
    
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

    func configure(with dayState: CalendarStateModel.CalendarState) {
        weekDayLabel.text = dayState.date.weekday
        dayLabel.text = dayState.date.day
        [dayLabel, weekDayLabel].forEach {
            $0.font = .systemFont(ofSize: 14, weight: .semibold)
            $0.textAlignment = .center
            $0.textColor = .white
        }
        
        let moodName = dayState.moodOfTheDay?.rawValue ?? "noMood"

        moodView.image = .init(named: moodName)
        moodView.contentMode = .scaleAspectFit
        
        configureBackgroundColor(dayState.isCurrentDay)
        
        setNeedsLayout()
    }

    private func configureBackgroundColor(_ isCurrentDay: Bool) {
        dayStackView.configure(spacing: 4)
        dayStackView.backgroundColor = isCurrentDay ? .mpDarkPurple : .clear
    }

    private func setupView() {
        dayStackView.addArrangedSubviews([
            weekDayLabel,
            dayLabel,
            moodView,
        ])
        addSubview(dayStackView)
        dayStackView.roundCorners(corners: .allCorners, radius: 16)
        dayStackView.distribution = .fill
        dayStackView.layoutMargins = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        dayStackView.isLayoutMarginsRelativeArrangement = true
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dayStackView.topAnchor.constraint(equalTo: self.topAnchor),
            dayStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            dayStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dayStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            moodView.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
}
