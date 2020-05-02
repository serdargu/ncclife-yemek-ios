//
//  Menu.swift
//  NCClife Yemek
//
//  Created by Serdar Güzel on 24.09.2017.
//  Copyright © 2017 Serdar Güzel. All rights reserved.
//

import Foundation
import ObjectMapper

class Menu: NSObject, NSCoding, Mappable {
    
    var name:String?
    var foods:[Food]?
    
    init(name: String, foods: [Food]) {
        self.name = name
        self.foods = foods
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let foods = aDecoder.decodeObject(forKey: "foods") as! [Food]
        self.init(name: name, foods: foods)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(foods, forKey: "foods")
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        foods <- map["foods"]
    }
    
}
