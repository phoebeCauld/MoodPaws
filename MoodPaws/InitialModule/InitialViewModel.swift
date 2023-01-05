//
//  InitialViewModel.swift
//  MoodPaws
//
//  Created by Perova Viktoriya Dmitrievna on 04.01.2023.
//

import Foundation

protocol IInitialViewModel: AnyObject {
    func showNextPet(at number: Int) -> String
    func didSelectPetSupport(at position: Int)
}

final class InitialViewModel: IInitialViewModel {
    var state: InitialModelViewState {
        .init(
            pets: model.pets,
            petsImage: model.pets.map { $0.imageName }
        )
    }
    private var router: IRouter
    private var model: InitialModel

    init(
        router: IRouter,
        model: InitialModel
    ) {
        self.router = router
        self.model = model
    }

    func didSelectPetSupport(at position: Int) {
        print("Select as a pet: \(model.pets[position].kindOfPet)")
    }

    func showNextPet(at number: Int) -> String {
        return state.petsImage[number]
    }
}


struct InitialModelViewState {
    let pets: [PetMock]
    let petsImage: [String]
}
