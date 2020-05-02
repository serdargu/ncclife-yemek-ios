//
//  Utils.swift
//  NCClife Yemek
//
//  Created by Serdar Güzel on 30.09.2017.
//  Copyright © 2017 Serdar Güzel. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class Utils {

    let userDefaults = UserDefaults.standard

    func alertController(message: String) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: message + "\n\n", preferredStyle: .alert)
        let spinnerIndicator = UIActivityIndicatorView(style: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 70.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        return alertController
    }
    
    // Function to check restaurant cache version
    func checkRestaurantsCacheVersion(completionHandler: @escaping (Bool?, Error?) -> ()) {
        checkCacheVersion(type: "restaurant", completionHandler: completionHandler)
    }
    
    // Function to check dining hall cache version
    func checkDininghallCacheVersion(completionHandler: @escaping (Bool?, Error?) -> ()) {
        checkCacheVersion(type: "dininghall", completionHandler: completionHandler)
    }
    
    // Function to check cache version
    private func checkCacheVersion(type: String, completionHandler: @escaping (Bool?, Error?) -> ()) {

        var API_URL:String
        var CACHE_KEY:String
        switch(type) {
            case "restaurant":
                API_URL = RESTAURANTS_CACHEVERSION_API_URL
                CACHE_KEY = RESTAURANTS_CACHEVERSION_DECODE_KEY
                break
            default:
                API_URL = DININGHALL_CACHEVERSION_API_URL
                CACHE_KEY = DININGHALL_CACHEVERSION_DECODE_KEY
                break
        }
        
        if let oldCacheVersion = userDefaults.string(forKey: CACHE_KEY) {
            
            AF.request("\(API_URL)").responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let jsonResponse = value as AnyObject? {
                        if let newCacheVersion = jsonResponse["cacheVersion"] as? String {
                            if(oldCacheVersion != newCacheVersion) {
                                completionHandler(true, nil)
                            }else{
                                completionHandler(false, nil) //false
                            }
                        }
                    }
                case .failure(let error):
                    completionHandler(false, error) // false
                }
            }
        }else{
            completionHandler(true, nil)
        }
    }
       
    // Function to update restaurants
    func updateRestaurants(completionHandler: @escaping (Bool?, Error?) -> ()) {
        
        AF.request(RESTAURANTS_API_URL).responseObject { (response: DataResponse<RestaurantsJsonResponse, AFError>) in
            
            switch response.result {
                case .success(let restaurantsJsonResponse):
                    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: restaurantsJsonResponse)
                    self.userDefaults.set(encodedData, forKey: RESTAURANTS_JSON_RESPONSE_DECODE_KEY)
                    self.userDefaults.set(restaurantsJsonResponse.cacheVersion, forKey: RESTAURANTS_CACHEVERSION_DECODE_KEY)
                    self.userDefaults.synchronize()
                    completionHandler(true, nil)
                
                case .failure(let error):
                    completionHandler(false, error)
            }
            
        }
        
    }
    
    // Function to update dining hall menus
    func updateDininghall(completionHandler: @escaping (Bool?, Error?) -> ()) {
        
        AF.request(DININGHALL_API_URL).responseObject { (response: DataResponse<DininghallJsonResponse, AFError>) in
            switch response.result {
                case .success(let dininghallJsonResponse):
                    
                    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: dininghallJsonResponse)
                    self.userDefaults.set(encodedData, forKey: DININGHALL_JSON_RESPONSE_DECODE_KEY)
                    self.userDefaults.set(dininghallJsonResponse.cacheVersion, forKey: DININGHALL_CACHEVERSION_DECODE_KEY)
                    self.userDefaults.synchronize()
                    completionHandler(true, nil)
    
                case .failure(let error):
                    completionHandler(false, error)
            }
            
        }

    }
    
}
