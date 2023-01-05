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

protocol IRouter: MainRouter {
    func showInitialVC()
    func popToRoot()
}

class Router: IRouter{
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
    

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
