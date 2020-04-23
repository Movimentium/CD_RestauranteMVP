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
        presenter.dishEatenNow()
    }
    
    @IBAction func onRateBtn() {
        showRateAlert()
    }
    
    @IBAction func onResetBtn() {
        showResetAlert()
    }
    

    
    // MARK: - RestauranteViewInterface
    func update(withDish dish: DishInfo) {
        imgVw.image = UIImage(named: dish.imageName ?? "")
        lblName.text = dish.name
        lblIsFavourite.text = (dish.isFavorite ? "*Favorito*" : " ")
        updateEatingInfo(withDish: dish)
        updateRating(with: dish.rating)
    }
    
    func updateEatingInfo(withDish dish:DishInfo) {
        lblEaten.text = "Veces degustado: \(dish.timesEaten)"
        lblLastEaten.text = "Última degustación: \(presenter.strDate(fromDate: dish.lastEaten))"
    }
    
    func updateRating(with value: Double) {
        lblRating.text = "Valoración \(value)/5"
    }
    
    func showRateAlert() {
        let alertVC = UIAlertController(title: "Valora el plato", message: "De 0 a 5", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let rateAction = UIAlertAction(title: "Valorar", style: .default) { [weak alertVC, weak self] (action) in
            self?.presenter.tryToRate(with: alertVC?.textFields?.first?.text ?? "-1")
        }
        alertVC.addAction(rateAction)
        alertVC.addAction(cancelAction)
        alertVC.addTextField { (textfield) in
            textfield.keyboardType = .decimalPad
        }
        present(alertVC, animated: true, completion: nil)
    }
    
    func showResetAlert() {
        let alertVC = UIAlertController(title: "¿Borrar datos de este plato?",
                                        message: nil,
                                        preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Borrar", style: .destructive) { [weak self] (action) in
            self?.presenter.resetDishSelected()
        }
        alertVC.addAction(deleteAction)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
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
