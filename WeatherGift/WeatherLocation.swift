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
    
    func getData() {
        let coordinates = "\(latitude),\(longtitude)"
        let urlString = "\(APIurls.darkSkyURL)\(APIkeys.darkSkyKey)/\(coordinates)"
        
        //create URL
        guard let url = URL(string: urlString) else {
            print ("ERROR: could not get URL from \(urlString)")
        return
        }
        
        //create session
        let session = URLSession.shared
        
        //create data with .dataTask method
        let task = session.dataTask(with: url) {
            (data, response, error) in if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            
            //note: there are some additional things that could go wrong when using URL session,  but we shouldn't experience them, so we'll ignore testing for these for now...
            
            //deal with the data
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("\(json)")
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
