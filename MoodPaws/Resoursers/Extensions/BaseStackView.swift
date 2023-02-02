//
//  BaseStackView.swift
//  MoodPaws
//
//  Created by Perova Viktoriya Dmitrievna on 02.02.2023.
//

import UIKit


final class BaseStackView: UIStackView {
    init(
        axis: NSLayoutConstraint.Axis = .vertical,
        spacing: CGFloat = 0
    ) {
        super.init(frame: .zero)

        self.axis = axis
        self.spacing = spacing
        setupStackConfigurations()
    }
    
    func setupStackConfigurations() {
        self.distribution = .fillEqually
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
