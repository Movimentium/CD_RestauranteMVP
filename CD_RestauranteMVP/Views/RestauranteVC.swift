//
//  RestauranteVC.swift
//  CD_RestauranteMVP
//
//  Created by Miguel on 23/04/2020.
//  Copyright © 2020 Miguel Gallego Martín. All rights reserved.
//

import UIKit

class RestauranteVC: UIViewController, RestauranteViewInterface, UIPickerViewDataSource, UIPickerViewDelegate {
  
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblEaten: UILabel!
    @IBOutlet weak var lblLastEaten: UILabel!
    @IBOutlet weak var lblIsFavourite: UILabel!
    private let presenter = RestaurantePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewInterface = self
        picker.dataSource = self
        picker.delegate = self
        pickerView(picker, didSelectRow: 0, inComponent: 0)
    }
    
    // MARK: - IBActions
    @IBAction func onRequestBtn() {
    }
    
    @IBAction func onRateBtn() {
    }
    
    // MARK: - RestauranteViewInterface
    func update(withDish dish: DishInfo) {
        lblName.text = dish.name
        lblRating.text = "Valoración \(dish.rating)/5"
        lblEaten.text = "Veces degustado: \(dish.timesEaten)"
        lblLastEaten.text = "Última degustación: \(presenter.strDate(fromDate: dish.lastEaten))"
        lblIsFavourite.text = (dish.isFavorite ? "*Favorito*" : "")
        imgVw.image = UIImage(named: dish.imageName ?? "")
    }
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.numOfDishes
    }
 
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.dishName(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(self.classForCoder) \(#function) row: \(row)")
        presenter.didSelect(dishId: row)
    }
}
