//
//  AssemblyBuilder.swift
//  MoodPaws
//
//  Created by Perova Viktoriya Dmitrievna on 04.01.2023.
//

import UIKit

protocol AssemblyBuilder {
    func createInitialVC(router: IRouter) -> UIViewController
    func createMainPageVC(router: IRouter) -> UIViewController
    func createCurrentMoodCreatorVC(router: IRouter, model: CurrentMoodCreatorModel) -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyBuilder {
    private let componentsFactory = ComponentsFactory()

    func createInitialVC(router: IRouter) -> UIViewController {
        let model = InitialModel()
        let viewModel = InitialViewModel(router: router, model: model)
        return InitialViewController(viewModel: viewModel, componentsFactory: componentsFactory)
    }

    func createMainPageVC(router: IRouter) -> UIViewController {
        let viewModel = MainPageViewModel(router: router)
        return MainPageViewController(viewModel: viewModel, componentsFactory: componentsFactory)
    }

    func createCurrentMoodCreatorVC(router: IRouter, model: CurrentMoodCreatorModel) -> UIViewController {
        let viewModel = CurrentMoodCreatorViewModel(router: router, model: model)
        return CurrentMoodCreatorViewController(viewModel: viewModel, componentsFactory: componentsFactory)
    }
}
