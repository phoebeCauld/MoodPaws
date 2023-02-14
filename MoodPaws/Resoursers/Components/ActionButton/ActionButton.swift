//
//  ActionButton.swift
//  MoodPaws
//
//  Created by Perova Viktoriya Dmitrievna on 13.02.2023.
//

import UIKit

final class ActionButton: UIButton {

    init() {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureButton(with model: ActionButtonModel) {
        let title = NSAttributedString(
            string: model.title,
            attributes: [
                .font: UIFont.systemFont(ofSize: model.textSize, weight: model.textWeight),
                .foregroundColor: model.foregroundColor
            ])
        self.setAttributedTitle(title, for: .normal)
        self.roundCorners(corners: .allCorners, radius: model.cornerRadius)
        self.backgroundColor = model.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
