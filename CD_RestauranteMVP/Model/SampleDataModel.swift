//
//  SampleDataModel.swift
//  CD_RestauranteMVP
//
//  Created by Miguel on 23/04/2020.
//  Copyright © 2020 Miguel Gallego Martín. All rights reserved.
//

import UIKit

class DishInfo {
    var imageName: String?
    var name: String?
    var rating: Double = 0.0
    var isFavorite: Bool = false
    var timesEaten: Int32 = 0
    var lastEaten: Date?
}

class DishFromPlist: Codable {
    var name: String
    var searchKey: String
    var imageName: String
    var tintColor: TintColor
    var lastEaten: Date
    var timesEaten: Int32
    var rating: Double
    var isFavorite: Bool
}

class TintColor: Codable {
    var red: Float
    var green: Float
    var blue: Float
}

extension DishFromPlist {
    func descr() -> String {
        """
        --------------------------
        searchKey: \(searchKey)
        name: \(name)
        tintColor:
        \(tintColor.descr())
        lastEaten: \(lastEaten)
        timesEaten: \(timesEaten)
        rating: \(rating)
        isFavorite: \(isFavorite)
        """
    }
}

extension TintColor {
    func descr() -> String {
        """
            red: \(red)
            green: \(green)
            blue: \(blue)
        """
    }
}

extension DishInfo {
    func descr() -> String {
        """
        --------------------------
        name: \(String(describing: name))
        tintColor:
        lastEaten: \(String(describing: lastEaten))
        timesEaten: \(timesEaten)
        rating: \(rating)
        isFavorite: \(isFavorite)
        """
    }
}
