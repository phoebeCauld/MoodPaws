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
    
    func fetchAllDaysMoods() -> [DayMood] {
        var days: [DayMood] = []
        do {
            days = try context.fetch(DayMood.fetchRequest())
        } catch  {
            print("Failed with loading days data \(error.localizedDescription)")
        }
        
        return days
    }

    func fetchCurrentDay() -> DayMood {
        var todayMoodModel = DayMood(context: context)
        let fetchRequest = DayMood.fetchRequest()
        let calendar = Calendar.current
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)

        let predicate = NSPredicate(format: "day >= %@ AND day < %@", startOfDay as NSDate, endOfDay! as NSDate)
        fetchRequest.predicate = predicate

        do {
            if let todayMood = try context.fetch(fetchRequest).first {
                todayMoodModel = todayMood
            } else {
                todayMoodModel.day = Date()
                saveData()
            }
        } catch  {
            print("Failed with loading days data \(error.localizedDescription)")
        }
        
        return todayMoodModel
    }
}
