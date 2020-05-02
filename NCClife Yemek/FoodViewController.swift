//
//  FoodViewController.swift
//  NCClife Yemek
//
//  Created by Serdar Güzel on 25.10.2017.
//  Copyright © 2017 Serdar Güzel. All rights reserved.
//

import Foundation
import UIKit

class FoodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var data:Restaurant!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var callButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = data.name
        
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.sectionHeaderHeight = 40
        
        callButton.target = self;
        callButton.action = #selector(callButtonClicked)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.menus!.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.menus![section].foods!.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        view.backgroundColor = UIColor(red:0.20, green:0.29, blue:0.36, alpha:1.0)
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: tableView.frame.size.width, height: 20))
        label.text = data.menus![section].name
        label.font = UIFont(name: "Helvetica Neue", size: 18)
        label.textColor = UIColor.white
        
        view.addSubview(label)
        
        return view
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodCell
        
        cell.name.text = data.menus![indexPath.section].foods![indexPath.row].name
        cell.price.text = "₺ " + data.menus![indexPath.section].foods![indexPath.row].price
        cell.desc.text = data.menus![indexPath.section].foods![indexPath.row].desc
        return cell
        
    }
    
    
    @objc func callButtonClicked() {
        
        let alertController = UIAlertController(title: nil, message: "Lütfen aramak istediğiniz numarayı seçin.", preferredStyle: .actionSheet)
        
        for phone in self.data.phones!{
            
            alertController.addAction(UIAlertAction(title: phone, style: .default) { action in
                
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
        
    }
    
}


