//
//  DininghallJsonResponse.swift
//  NCClife Yemek
//
//  Created by Serdar Güzel on 1.10.2017.
//  Copyright © 2017 Serdar Güzel. All rights reserved.
//

import Foundation
import ObjectMapper

class DininghallJsonResponse: NSObject, NSCoding, Mappable {
    
    var cacheVersion:String?
    var dininghallMenus:[DiningHallMenu]?
    
    init(cacheVersion: String, dininghallMenus: [DiningHallMenu]) {
        self.cacheVersion = cacheVersion
        self.dininghallMenus = dininghallMenus
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let cacheVersion = aDecoder.decodeObject(forKey: "cacheVersion") as! String
        let dininghallMenus = aDecoder.decodeObject(forKey: "dininghallMenus") as! [DiningHallMenu]
        self.init(cacheVersion: cacheVersion, dininghallMenus: dininghallMenus)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(cacheVersion, forKey: "cacheVersion")
        aCoder.encode(dininghallMenus, forKey: "dininghallMenus")
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        cacheVersion <- map["cacheVersion"]
        dininghallMenus <- map["dininghallMenus"]
    }
    
}
