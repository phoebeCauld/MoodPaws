import UIKit

final class MoodCalendarView: UIView {
    private var componentsFactory: IComponentsFactory

    private lazy var titleLable = componentsFactory.makeCommonTextLabel()
    private lazy var daysStackView = componentsFactory.makeBaseStackView()
    
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

    func configure(with state: MoodCalendarModel) {
        titleLable.configure(with: TitleLabelModel(title: "Current Week", textColor: .white))
        configureDaysStackView(with: state.moods)
       
    }

    private func configureDaysStackView(with moods: [MoodCalendarModel.MoodDay]) {
        daysStackView.configure(axis: .horizontal, spacing: 8)
        daysStackView.arrangedSubviews.forEach{ daysStackView.removeArrangedSubview($0) }
        
        let moodDaysViews = moods.map { model in
            let view = DayView(componentsFactory: componentsFactory)
            view.configure(with: model)
            return view
        }
        
        daysStackView.addArrangedSubviews(moodDaysViews)
    }

    private func setupView() {
        addSubviews([
            titleLable,
            daysStackView,
        ])

    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: self.topAnchor),
            titleLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLable.leadingAnchor.constraint(equalTo: self.leadingAnchor),

            daysStackView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 12),
            daysStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            daysStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            daysStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }
}
