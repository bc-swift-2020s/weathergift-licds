//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Yi Li on 3/22/20.
//  Copyright © 2020 Yi Li. All rights reserved.
//

import Foundation

class WeatherLocation: Codable{
    var name: String
    var latitude: Double
    var longtitude: Double
    
    init(name:String, latitude: Double, longtitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longtitude = longtitude
    }
}
