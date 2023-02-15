//
//  Router.swift
//  MoodPaws
//
//  Created by Perova Viktoriya Dmitrievna on 04.01.2023.
//
import UIKit

protocol MainRouter {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilder? { get set }
}

protocol RouterDelegate: AnyObject {
    func refreshViewModel()
}

protocol IRouter: MainRouter {
    var delegate: RouterDelegate? { get set }
    func showInitialVC()
    func showMainPageVC()
    func showCurrentMoodCreatorVC(with model: CurrentMoodCreatorModel)
    func popToRoot()
    func dismissAndRefreshTopViewController()
}


class Router: IRouter{
    weak var delegate: RouterDelegate?
    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblyBuilder?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilder) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func showInitialVC() {
        if let navigationController = navigationController {
            guard let initialVC = assemblyBuilder?.createInitialVC(router: self) else { return }
            navigationController.viewControllers = [initialVC]
        }
    }
    
    func showMainPageVC() {
        if let navigationController = navigationController {
            guard let mainPageVC = assemblyBuilder?.createMainPageVC(router: self) else { return }
            navigationController.viewControllers = [mainPageVC]
        }
    }

    func showCurrentMoodCreatorVC(with model: CurrentMoodCreatorModel) {
        if let navigationController = navigationController {
            guard let currentMoodCreatorVC = assemblyBuilder?.createCurrentMoodCreatorVC(router: self, model: model) else {
                return
            }
            currentMoodCreatorVC.modalPresentationStyle = .formSheet
            navigationController.present(currentMoodCreatorVC, animated: true)
        }
    }
    
    func dismissAndRefreshTopViewController() {
        if let navigationController {
            let modalVC = navigationController.viewControllers.last?.presentedViewController
            modalVC?.dismiss(animated: true)
            delegate?.refreshViewModel()
        }
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
