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

    func support(for mood: Mood) -> String {
        switch mood {
        case .good:
            return "Good job! Keep calm and make great things today!"
        case .bad:
            return "Don't worry, we all have a bad day sometimes. Relax and take your time!"
        }
    }
}


enum Mood {
    case good
    case bad
}

enum PetType: Int32 {
    case dog = 0
    case cat = 1
    case hamster = 2
}
