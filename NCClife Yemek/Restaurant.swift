//
//  Restaurant.swift
//  NCClife Yemek
//
//  Created by Serdar Güzel on 24.09.2017.
//  Copyright © 2017 Serdar Güzel. All rights reserved.
//

import Foundation
import ObjectMapper

class Restaurant: NSObject, NSCoding, Mappable {
    
    var id:Int?
    var image:String?
    var name:String?
    var desc:String?
    var phones:[String]?
    var menus:[Menu]?
    
    init(id: Int, name: String, desc: String, phones: [String], menus: [Menu]) {
        self.id = id
        self.name = name
        self.desc = desc
        self.phones = phones
        self.menus = menus
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! Int
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let desc = aDecoder.decodeObject(forKey: "desc") as! String
        let phones = aDecoder.decodeObject(forKey: "phones") as! [String]
        let menus = aDecoder.decodeObject(forKey: "menus") as! [Menu]
        self.init(id: id, name: name, desc: desc, phones: phones, menus: menus)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(desc, forKey: "desc")
        aCoder.encode(phones, forKey: "phones")
        aCoder.encode(menus, forKey: "menus")
    }
    
    required init?(map: Map){
        
    }
    
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        desc <- map["desc"]
        phones <- map["phones"]
        menus <- map["menus"]
    }
    
}
