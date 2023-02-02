//
//  CalendarView.swift
//  MoodPaws
//
//  Created by Perova Viktoriya Dmitrievna on 27.01.2023.
//

import UIKit

final class MoodCalendarView: UIView {
    private let daysStackView = BaseStackView(axis: .horizontal, spacing: 8)
    
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

    func configure(with state: CalendarStateModel) {
        daysStackView.arrangedSubviews.forEach{ daysStackView.removeArrangedSubview($0) }
        
        let moodDaysViews = state.moods.map { model in
            let view = DayView()
            view.configure(with: model)
            return view
        }
        
        daysStackView.addArrangedSubviews(moodDaysViews)
       
    }

    private func setupView() {
        addSubview(daysStackView)

        //daysStackView.distribution = .fillProportionally
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            daysStackView.topAnchor.constraint(equalTo: self.topAnchor),
            daysStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            daysStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            daysStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }
}
