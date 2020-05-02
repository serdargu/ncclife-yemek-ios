//
//  DininghallViewController.swift
//  NCClife Yemek
//
//  Created by Serdar Güzel on 24.09.2017.
//  Copyright © 2017 Serdar Güzel. All rights reserved.
//

import UIKit

class DininghallViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var noMenuLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let dateFormatter = DateFormatter()
    var dininghallMenus: [DiningHallMenu]!
    var currentIndex: Int!
    
    let utils = Utils()
    var updatingAlert: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        segmentedControl.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor(red:0.20, green:0.29, blue:0.36, alpha:1.0)], for: .normal)
        
        datePicker.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        self.updatingAlert = self.utils.alertController(message: "Menü güncelleniyor")
        
        DispatchQueue.main.async() {
            
            self.utils.checkDininghallCacheVersion { responseObject, error in
                
                // If error occurs
                if error != nil {
                    
                    self.updateTable()
                    
                } else {
                    
                    // If cache is old or doesn't exist
                    if responseObject == true {
                        
                        self.present(self.updatingAlert, animated: false, completion: nil)
                        
                        self.utils.updateDininghall { responseObject, error in
                            
                            self.updatingAlert.dismiss(animated: true, completion: nil)
                            self.updateTable()
                            
                        }
                        
                    } else {
                        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        self.showCurrentDininghallMenu()
    }
    
    @objc func valueChanged(_ sender: Any) {
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        showDininghallMenu(date: dateFormatter.string(from: datePicker.date), type: segmentedControl.selectedSegmentIndex)
        
    }
    
    func showCurrentDininghallMenu() {
        
        let date = Date()
        
        dateFormatter.dateFormat = "HH"
        let hour = Int(dateFormatter.string(from: date))
        
        let type: Int
        if hour! > 14 {
            segmentedControl.selectedSegmentIndex = 1
            type = 1
        } else {
            segmentedControl.selectedSegmentIndex = 0
            type = 0
        }
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        showDininghallMenu(date: dateFormatter.string(from: date), type: type)
        
    }

    func showDininghallMenu(date: String, type: Int) {
        
        if let i = self.dininghallMenus?.firstIndex(where: { $0.date == date && $0.type == type }) {
            
            self.currentIndex = i
            tableView.isHidden = false
            noMenuLabel.isHidden = true
            
        }else{
            
            self.currentIndex = nil
            tableView.isHidden = true
            noMenuLabel.isHidden = false
            
        }
        
        self.tableView.reloadData()
        
    }
    
    func updateTable() {
        let decoded = UserDefaults.standard.object(forKey: DININGHALL_JSON_RESPONSE_DECODE_KEY) as? Data
        if decoded != nil {
            let dininghallJsonResponse = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! DininghallJsonResponse
            self.dininghallMenus = dininghallJsonResponse.dininghallMenus
        }
        
        self.tableView.reloadData()
        self.showCurrentDininghallMenu()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.currentIndex != nil {
            return 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DininghallCell")
        
        if indexPath.row == 0 {
            cell?.textLabel?.text = "Çorba"
            cell?.detailTextLabel?.text = self.dininghallMenus[self.currentIndex].soup
        }else if indexPath.row == 1 {
            cell?.textLabel?.text = "Ana Yemek"
            cell?.detailTextLabel?.text = self.dininghallMenus[self.currentIndex].main_dinner
        }else if indexPath.row == 2 {
            cell?.textLabel?.text = "3. Çeşit"
            cell?.detailTextLabel?.text = self.dininghallMenus[self.currentIndex].third_kind
        }else if indexPath.row == 3 {
            cell?.textLabel?.text = "4. Çeşit"
            cell?.detailTextLabel?.text = self.dininghallMenus[self.currentIndex].fourth_kind
        }else {
            cell?.textLabel?.text = "5. Çeşit"
            cell?.detailTextLabel?.text = self.dininghallMenus[self.currentIndex].fifth_kind
        }
        
        return cell!
        
    }
    
}

