//
//  RestauranteDB.swift
//  CD_RestauranteMVP
//
//  Created by Miguel on 23/04/2020.
//  Copyright © 2020 Miguel Gallego Martín. All rights reserved.
//

import CoreData

class RestauranteDB {
    
    static let single = RestauranteDB()
    private init() {
        if numOfDishes == 0 {
            setupDB()
        }
        print("\(RestauranteDB.self) \(#function) numOfDishes: \(numOfDishes)")
    }
    
    var numOfDishes:Int {
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "\(Dish.self)")
        do {
            return try moctx.count(for: fr)
        } catch {
            print("\(RestauranteDB.self) \(#function) ERROR")
            print(error.localizedDescription)
            return -1
        }
    }

    private var dishSelected: Dish! {
        didSet {print("\(RestauranteDB.self) \(#function)")}
    }
    
    func dishSelectedInfo() -> DishInfo {
        let d = DishInfo()
        dishSelected.toDishInfo(d)
        return d
    }
    
    func dishEatenNow() {
        dishSelected.timesEaten += 1
        dishSelected.lastEaten = Date()
        saveContext()
    }
    
    func rateDishSelected(with value:Double) {
        dishSelected.rating = value
        saveContext()
    }
    
    func dishInfo(forId id:Int) -> DishInfo {
        let d = DishInfo()
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "\(Dish.self)")
        fr.predicate = NSPredicate(format: "id = %d", id)
        do {
            let results = try moctx.fetch(fr) as! [Dish]
            if let firstDish = results.first {
                dishSelected = firstDish
                firstDish.toDishInfo(d)
            }
        } catch {
            print("\(RestauranteDB.self) \(#function) ERROR")
            print(error.localizedDescription)
        }
        print(d.descr())
        return d
    }
    
    private lazy var dishNames:[String]? = {
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "\(Dish.self)")
        let sortDescr = NSSortDescriptor(key: "id", ascending: true)
        fr.sortDescriptors = [sortDescr]
        if let results:[Dish] = try? moctx.fetch(fr) as? [Dish] {
            var names:[String] = []
            results.forEach { names.append($0.name ?? "?") }
            return names
        } else  {
            print("\(RestauranteDB.self) \(#function) ERROR")
            return nil
        }
    }()
    
    func dishName(at i:Int) -> String {
        if let names = dishNames, i < names.count {
            return names[i]
        }
        return "?"
    }
    
    private func setupDB() {
        print("\(RestauranteDB.self) \(#function)")
        
        var arrDishAux:[DishFromPlist] = []
        let sampleDataURL:URL = Bundle.main.url(forResource: "SampleData", withExtension: "plist")!
        do {
            let sampleData:Data = try Data(contentsOf: sampleDataURL)
            arrDishAux = try PropertyListDecoder().decode([DishFromPlist].self, from: sampleData)
        } catch  {
            print("\(RestauranteDB.self) \(#function) ERROR")
            print(error.localizedDescription)
        }
        var i:Int32 = 0
        for dishAux in arrDishAux {
            let dishEntity = NSEntityDescription.entity(forEntityName: "\(Dish.self)", in: moctx)!
            let dish = Dish(entity: dishEntity, insertInto: moctx)
            dish.copyFromDishModel(dishAux)
            dish.id = i
            i += 1
        }
        saveContext()
        print("\(RestauranteDB.self) \(#function) numOfDishes: \(numOfDishes)")
    }
    
    // MARK: - Core Data stack
    
    private lazy var moctx: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CD_RestauranteMVP")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
