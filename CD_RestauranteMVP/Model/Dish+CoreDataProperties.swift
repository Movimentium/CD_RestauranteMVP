//
//  Dish+CoreDataProperties.swift
//  CD_RestauranteMVP
//
//  Created by Miguel on 23/04/2020.
//  Copyright © 2020 Miguel Gallego Martín. All rights reserved.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var imageName: String?
    @NSManaged public var name: String?
    @NSManaged public var searchKey: String?
    @NSManaged public var rating: Double
    @NSManaged public var isFavorite: Bool
    @NSManaged public var timesEaten: Int32

}
