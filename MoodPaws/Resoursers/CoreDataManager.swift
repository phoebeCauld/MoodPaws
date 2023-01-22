import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func saveData() {
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed with saving data: \(error.localizedDescription)")
        }
    }
    
    func fetchPetSupport() -> Pet? {
        var petSupport: Pet?

        do {
            let pet = (try context.fetch(PetSupport.fetchRequest())).first

            petSupport = .init(
                name: pet?.name,
                kindOfPet: pet?.petSupport ?? .cat,
                age: pet?.age
            )
        } catch  {
            print("Failed with loading data \(error.localizedDescription)")
        }

        return petSupport
    }
}
