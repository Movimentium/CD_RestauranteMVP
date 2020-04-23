//
//  RestaurantePresenter.swift
//  CD_RestauranteMVP
//
//  Created by Miguel on 23/04/2020.
//  Copyright © 2020 Miguel Gallego Martín. All rights reserved.
//

import Foundation

protocol RestauranteViewInterface: AnyObject {
    func updateDish(withImageName imageName:String)
}

class RestaurantePresenter {
    private let db = RestauranteDB.single
    weak var viewInterface: RestauranteViewInterface?
    
    var numOfDishes: Int {
        return db.numOfDishes
    }
    
    func dishName(at i:Int) -> String {
        return db.dishName(at: i)
    }
    
    func didSelect(dishIndex i:Int) {
        
    }
    
    func dishImageName(at i:Int) -> String {
        return "TODO"
    }
    
}
