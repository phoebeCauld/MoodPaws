//
//  ComponentsFactory.swift
//  MoodPaws
//
//  Created by Perova Viktoriya Dmitrievna on 11.02.2023.
//

import Foundation


protocol IComponentsFactory {
    func makeBaseStackView() -> BaseStackView
    func makeCommonTextLabel() -> CommonTextLabelView
    func makeBaseCell() -> NoteCellView
    func makeActionButton() -> ActionButton
}

final class ComponentsFactory: IComponentsFactory {
    func makeBaseStackView() -> BaseStackView {
        BaseStackView()
    }
    
    func makeCommonTextLabel() -> CommonTextLabelView {
        CommonTextLabelView()
    }

    func makeBaseCell() -> NoteCellView {
        NoteCellView()
    }

    func makeActionButton() -> ActionButton {
        ActionButton()
    }
}
