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
    func updateEatingInfo(withDish dish:DishInfo)
    func updateRating(with value:Double)
    func showRateAlert()
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
    
    func dishEatenNow() {
        db.dishEatenNow()
        let dishInfo = db.dishSelectedInfo()
        viewInterface?.updateEatingInfo(withDish: dishInfo)
    }
 
    func tryToRate(with strValue: String) {
        let str = strValue.replacingOccurrences(of: ",", with: ".")
        let aDouble = (str as NSString).doubleValue
        print("\(RestaurantePresenter.self) \(#function) \(aDouble)")
        if aDouble < 0.0 || aDouble > 5.0 {
            viewInterface?.showRateAlert()
        } else {
            db.rateDishSelected(with: aDouble)
            viewInterface?.updateRating(with: aDouble)
        }
    }
    
    func resetDishSelected() {
        db.resetDishSelected()
        let dishInfo = db.dishSelectedInfo()
        viewInterface?.updateRating(with: dishInfo.rating)
        viewInterface?.updateEatingInfo(withDish: dishInfo)
    }
    
    func strDate(fromDate d:Date?) -> String {
        guard let date = d else {
            return "?"
        }
        let dateForm = DateFormatter()
        dateForm.dateFormat = "dd/MM/YYYY HH:mm:ss"
        return dateForm.string(from: date)
    }
}
