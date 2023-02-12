//
//  ComponentsFactory.swift
//  MoodPaws
//
//  Created by Perova Viktoriya Dmitrievna on 11.02.2023.
//

import Foundation


protocol IComponentsFactory {
    func makeBaseStackView() -> BaseStackView
    func makeTitleLabel() -> TitleLbel
    func makeBaseCell() -> NoteCellView
}

final class ComponentsFactory: IComponentsFactory {
    func makeBaseStackView() -> BaseStackView {
        BaseStackView()
    }
    
    func makeTitleLabel() -> TitleLbel {
        TitleLbel()
    }

    func makeBaseCell() -> NoteCellView {
        NoteCellView()
    }
}
