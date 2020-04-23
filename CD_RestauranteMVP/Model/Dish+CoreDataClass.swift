//
//  Dish+CoreDataClass.swift
//  CD_RestauranteMVP
//
//  Created by Miguel on 23/04/2020.
//  Copyright © 2020 Miguel Gallego Martín. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Dish)
public class Dish: NSManagedObject {
    
    func copyFromDishModel(_ d:DishFromPlist) {
        name = d.name
        rating = d.rating
        imageName = d.imageName
        timesEaten = d.timesEaten
        isFavorite = d.isFavorite
        lastEaten = d.lastEaten
    }
    
    func toDishInfo(_ d:DishInfo) {
        d.name = name
        d.rating = rating
        d.imageName = imageName
        d.timesEaten = timesEaten
        d.isFavorite = isFavorite
        d.lastEaten = lastEaten
    }

}
