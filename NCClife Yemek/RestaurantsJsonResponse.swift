//
//  RestaurantsJsonResponse.swift
//  NCClife Yemek
//
//  Created by Serdar Güzel on 30.09.2017.
//  Copyright © 2017 Serdar Güzel. All rights reserved.
//

import Foundation
import ObjectMapper

class RestaurantsJsonResponse: NSObject, NSCoding, Mappable {

    var cacheVersion:String?
    var restaurants:[Restaurant]?
    
    init(cacheVersion: String, restaurants: [Restaurant]) {
        self.cacheVersion = cacheVersion
        self.restaurants = restaurants
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let cacheVersion = aDecoder.decodeObject(forKey: "cacheVersion") as! String
        let restaurants = aDecoder.decodeObject(forKey: "restaurants") as! [Restaurant]
        self.init(cacheVersion: cacheVersion, restaurants: restaurants)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(cacheVersion, forKey: "cacheVersion")
        aCoder.encode(restaurants, forKey: "restaurants")
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        cacheVersion <- map["cacheVersion"]
        restaurants <- map["restaurants"]
    }
    
}
