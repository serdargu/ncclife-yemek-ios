//
//  RestaurantsViewController.swift
//  NCClife Yemek
//
//  Created by Serdar Güzel on 24.09.2017.
//  Copyright © 2017 Serdar Güzel. All rights reserved.
//

import Foundation
import UIKit

class RestaurantsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var restaurants:[Restaurant]?

    let utils = Utils()
    var updatingAlert: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updatingAlert = self.utils.alertController(message: "Menü güncelleniyor")
        
        DispatchQueue.main.async() {
            
            self.utils.checkRestaurantsCacheVersion { responseObject, error in
                
                // If error occurs
                if error != nil {
                    
                    self.updateTable()
                    
                } else {
                    
                    // If cache is old or doesn't exist
                    if responseObject == true {
                        
                        self.present(self.updatingAlert, animated: false, completion: nil)
                        
                        self.utils.updateRestaurants() { responseObject, error in
                            
                            self.updateTable()
                            self.updatingAlert.dismiss(animated: true, completion: nil)
                            
                        }
                        
                    }else{
                        
                        self.updateTable()
                        
                    }
                    
                }
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTable() {
        
        let decoded = UserDefaults.standard.object(forKey: RESTAURANTS_JSON_RESPONSE_DECODE_KEY) as? Data
        if decoded != nil {
            let restaurantsJsonResponse = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! RestaurantsJsonResponse
            self.restaurants = restaurantsJsonResponse.restaurants
        }
        
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.restaurants != nil) {
            return self.restaurants!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        
        cell.data = restaurants![indexPath.row]
        cell.restaurantNameLabel.text = restaurants![indexPath.row].name
        cell.restaurantDescriptionLabel.text = restaurants![indexPath.row].desc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! RestaurantCell
        
        let foodController = storyboard?.instantiateViewController(withIdentifier: "FoodViewController") as! FoodViewController
        
        foodController.data = cell.data
        navigationController?.pushViewController(foodController, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let call = UITableViewRowAction(style: .normal, title: "\u{260F}\nAra") { action, index in
            
            let alertController = UIAlertController(title: nil, message: "Lütfen aramak istediğiniz numarayı seçin.", preferredStyle: .actionSheet)
            
            let cell = tableView.cellForRow(at: index) as! RestaurantCell
            
            var first = true
            var title = ""
            for phone in cell.data.phones!{
                
                if first == true {
                    title = "Genç Kafası " + phone
                    first = false
                }else{
                    title = phone
                }
                
                alertController.addAction(UIAlertAction(title: title, style: .default) { action in
                    
                    if let url = URL(string: "tel://\(String(describing: phone))") {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                })
                
            }
            
            alertController.addAction(UIAlertAction(title: "Vazgeç", style: .cancel) { action in })
            
            self.present(alertController, animated: true)
            tableView.setEditing(false, animated: true)
            
        }
        
        call.backgroundColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 102/255.0, alpha: 1.0)
        
        return [call]
    }


}

