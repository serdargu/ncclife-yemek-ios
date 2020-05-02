//
//  Constants.swift
//  NCClife Yemek
//
//  Created by Serdar Güzel on 1.10.2017.
//  Copyright © 2017 Serdar Güzel. All rights reserved.
//

import Foundation

// API Endpoints
let RESTAURANTS_CACHEVERSION_API_URL = "http://ncclife.net/api/v1/restaurants-cache.json"
let RESTAURANTS_API_URL = "http://ncclife.net/api/v1/restaurants.json?device=1"
let DININGHALL_CACHEVERSION_API_URL = "http://ncclife.net/api/v1/dininghall-cache.json"
let DININGHALL_API_URL = "http://ncclife.net/api/v1/dininghall.json"

// Decode Keys for Caching
let RESTAURANTS_CACHEVERSION_DECODE_KEY = "restaurantsCacheVersion"
let RESTAURANTS_JSON_RESPONSE_DECODE_KEY = "restaurantsJsonResponse"
let DININGHALL_CACHEVERSION_DECODE_KEY = "dininghallCacheVersion"
let DININGHALL_JSON_RESPONSE_DECODE_KEY = "dininghallJsonResponse"
