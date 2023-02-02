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
}

final class AssemblyModuleBuilder: AssemblyBuilder {
    func createInitialVC(router: IRouter) -> UIViewController {
        let model = InitialModel()
        let viewModel = InitialViewModel(router: router, model: model)
        return InitialViewController(viewModel: viewModel)
    }

    func createMainPageVC(router: IRouter) -> UIViewController {
        let viewModel = MainPageViewModel(router: router, model: MainPageModel())
        return MainPageViewController(viewModel: viewModel)
    }
}
