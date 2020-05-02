//
//  RestaurantCell.swift
//  NCClife Yemek
//
//  Created by Serdar Güzel on 25.10.2017.
//  Copyright © 2017 Serdar Güzel. All rights reserved.
//

import Foundation
import UIKit

class RestaurantCell: UITableViewCell {
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantDescriptionLabel: UILabel!
    
    var data:Restaurant!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
