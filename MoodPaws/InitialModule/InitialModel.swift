//
//  InitialModel.swift
//  MoodPaws
//
//  Created by Perova Viktoriya Dmitrievna on 04.01.2023.
//

struct InitialModel {
    let pets: [PetMock] = [
        .init(kindOfPet: .cat),
        .init(kindOfPet: .dog),
        .init(kindOfPet: .hamster)
    ]
}

struct PetMock {
    let name: String?
    let kindOfPet: PetType
    let age: Int?
    let imageName: String
    
    init(
        name: String? = nil,
        kindOfPet: PetType,
        age: Int? = nil
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

enum PetType {
    case dog
    case cat
    case hamster
}
