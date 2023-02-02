import UIKit

final class DayView: UIView {
    private let weekDayLabel = UILabel()
    private let dayLabel = UILabel()
    private let moodView = UIImageView()
    
    private let dayStackView = BaseStackView(spacing: 4)
    
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

    func configure(with dayState: CalendarStateModel.CalendarState) {
        weekDayLabel.text = dayState.date.weekday
        dayLabel.text = dayState.date.day
        [dayLabel, weekDayLabel].forEach {
            $0.font = .systemFont(ofSize: 14, weight: .semibold)
            $0.textAlignment = .center
        }
        
        let moodName = dayState.moodOfTheDay?.rawValue ?? "noMood"

        moodView.image = .init(named: moodName)
        moodView.contentMode = .scaleAspectFit
        
        setNeedsLayout()
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
        dayStackView.backgroundColor = .purple
        dayStackView.layoutMargins = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        dayStackView.isLayoutMarginsRelativeArrangement = true
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dayStackView.topAnchor.constraint(equalTo: self.topAnchor),
            dayStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            dayStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dayStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            moodView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
