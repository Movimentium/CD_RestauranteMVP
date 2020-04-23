//
//  RestaurantePresenter.swift
//  CD_RestauranteMVP
//
//  Created by Miguel on 23/04/2020.
//  Copyright © 2020 Miguel Gallego Martín. All rights reserved.
//

import Foundation

protocol RestauranteViewInterface: AnyObject {
    func update(withDish dish:DishInfo)
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
    
    func didSelect(dishId i:Int) {
        let dishInfo = db.dishInfo(forId: i)
        viewInterface?.update(withDish: dishInfo)
    }
    
 
    
    func strDate(fromDate d:Date?) -> String {
        guard let date = d else {
            return "?"
        }
        let dateForm = DateFormatter()
        dateForm.dateFormat = "dd/MM/YYYY HH:mm"
        return dateForm.string(from: date)
    }
}
