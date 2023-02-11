//
//  BaseStackView.swift
//  MoodPaws
//
//  Created by Perova Viktoriya Dmitrievna on 02.02.2023.
//

import UIKit


final class BaseStackView: UIStackView {
    init() {
        super.init(frame: .zero)

        setupStackConfigurations()
    }
    
    private func setupStackConfigurations() {
        self.distribution = .fillEqually
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func configure(axis: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = 0) {
        self.axis = axis
        self.spacing = spacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
