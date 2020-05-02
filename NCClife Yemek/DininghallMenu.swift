//
//  DininghallMenu.swift
//  NCClife Yemek
//
//  Created by Serdar Güzel on 24.09.2017.
//  Copyright © 2017 Serdar Güzel. All rights reserved.
//

import Foundation
import ObjectMapper

class DiningHallMenu: NSObject, NSCoding, Mappable {

    var date:String!
    var type:Int!
    var soup:String!
    var main_dinner:String!
    var third_kind:String!
    var fourth_kind:String!
    var fifth_kind:String!
    
    init(date: String, type: Int, soup: String, main_dinner: String, third_kind: String, fourth_kind: String, fifth_kind: String) {
        self.date = date
        self.type = type
        self.soup = soup
        self.main_dinner = main_dinner
        self.third_kind = third_kind
        self.fourth_kind = fourth_kind
        self.fifth_kind = fifth_kind
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let date = aDecoder.decodeObject(forKey: "date") as! String
        let type = aDecoder.decodeObject(forKey: "type") as! Int
        let soup = aDecoder.decodeObject(forKey: "soup") as! String
        let main_dinner = aDecoder.decodeObject(forKey: "main_dinner") as! String
        let third_kind = aDecoder.decodeObject(forKey: "third_kind") as! String
        let fourth_kind = aDecoder.decodeObject(forKey: "fourth_kind") as! String
        let fifth_kind = aDecoder.decodeObject(forKey: "fifth_kind") as! String
        self.init(date: date, type: type, soup: soup, main_dinner: main_dinner, third_kind: third_kind, fourth_kind: fourth_kind, fifth_kind: fifth_kind)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(soup, forKey: "soup")
        aCoder.encode(main_dinner, forKey: "main_dinner")
        aCoder.encode(third_kind, forKey: "third_kind")
        aCoder.encode(fourth_kind, forKey: "fourth_kind")
        aCoder.encode(fifth_kind, forKey: "fifth_kind")
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        date <- map["date"]
        type <- map["type"]
        soup <- map["soup"]
        main_dinner <- map["main_dinner"]
        third_kind <- map["third_kind"]
        fourth_kind <- map["fourth_kind"]
        fifth_kind <- map["fifth_kind"]
    }
}
