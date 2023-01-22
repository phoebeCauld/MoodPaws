import Foundation

protocol IInitialViewModel: AnyObject {
    func getNextPet(at number: Int) -> String
    func didSelectPetSupport(at position: Int)
    func addPetName(_ name: String)
    func pushMainPageViewController()
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
    private var choosenPetSupport = PetSupport(context: CoreDataManager.shared.context)

    init(
        router: IRouter,
        model: InitialModel
    ) {
        self.router = router
        self.model = model
    }

    func didSelectPetSupport(at position: Int) {
        let pet = state.pets[position]
        choosenPetSupport.petSupport = pet.kindOfPet
        choosenPetSupport.imageName = pet.imageName
        choosenPetSupport.age = pet.age ?? 0
    }
    
    func addPetName(_ name: String) {
        choosenPetSupport.name = name
        CoreDataManager.shared.saveData()
    }

    func getNextPet(at number: Int) -> String {
        return state.petsImage[number]
    }

    func pushMainPageViewController() {
        router.showMainPageVC()
    }
}


struct InitialModelViewState {
    let pets: [Pet]
    let petsImage: [String]
}
