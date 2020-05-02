//
//  Food.swift
//  NCClife Yemek
//
//  Created by Serdar Güzel on 24.09.2017.
//  Copyright © 2017 Serdar Güzel. All rights reserved.
//

import Foundation
import ObjectMapper

class Food: NSObject, NSCoding, Mappable{
    
    var name:String!
    var desc:String!
    var price:String!
    
    init(name: String, desc: String, price: String) {
        self.name = name
        self.desc = desc
        self.price = price
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let desc = aDecoder.decodeObject(forKey: "desc") as! String
        let price = aDecoder.decodeObject(forKey: "price") as! String
        self.init(name: name, desc: desc, price: price)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(desc, forKey: "desc")
        aCoder.encode(price, forKey: "price")
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        desc <- map["desc"]
        price <- map["price"]
    }
    
}
