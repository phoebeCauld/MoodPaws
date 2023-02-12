//
//  PetSupport+CoreDataClass.swift
//  
//
//  Created by Perova Viktoriya Dmitrievna on 22.01.2023.
//
//

import Foundation
import CoreData

@objc(PetSupport)
public class PetSupport: NSManagedObject {
    var petSupport: PetType {
        get {
            return PetType(rawValue: self.kindOfPet)!
        }
        set {
            self.kindOfPet = newValue.rawValue
        }
    }
}
