import Foundation

struct Pet {
    let name: String?
    let kindOfPet: PetType
    let age: Int32?
    let imageName: String
    
    init(
        name: String? = nil,
        kindOfPet: PetType,
        age: Int32? = nil
    ) {
        self.name = name
        self.kindOfPet = kindOfPet
        self.age = age

        switch kindOfPet {
        case .dog:
            self.imageName = "dog"
        case .cat:
            self.imageName = "cat"
        case .hamster:
            self.imageName = "hamster"
        }
    }
}

enum PetType: Int32 {
    case dog = 0
    case cat = 1
    case hamster = 2
}
