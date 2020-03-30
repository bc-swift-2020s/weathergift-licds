 //
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by Yi Li on 3/23/20.
//  Copyright © 2020 Yi Li. All rights reserved.
//

import Foundation

 private let dateFormatter: DateFormatter = {
     print("I just created a time formatter!")
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = " EEEE"
     return dateFormatter
 } ()
 
 struct DailyWeatherData: Codable {
    var dailyIcon: String
    var dailyWeekday: String
    var dailySummary: String
    var dailyHigh: Int
    var dailyLow: Int
 }
 
 class WeatherDetail: WeatherLocation {
    
    private struct Result: Codable {
        var timezone: String
        var currently: Currently
        var daily: Daily
    }
    
    private struct Currently: Codable {
        var temperature: Double
        var time: TimeInterval
    }
    
    private struct Daily: Codable {
        var summary: String
        var icon: String
        var data: [DailyData]
    }
    
    private struct DailyData: Codable {
        var icon: String
        var time: TimeInterval
        var summary: String
        var temperatureHigh: Double
        var temperatureLow: Double
    }
    var timezone = ""
    var currentTime = 0.0
    var temperature = 0
    var summary = ""
    var dailyIcon = ""
    var dailyWeatherData: [DailyWeatherData] = []
    
    func getData(completed: @escaping () -> () ) {
           let coordinates = "\(latitude),\(longtitude)"
           let urlString = "\(APIurls.darkSkyURL)\(APIkeys.darkSkyKey)/\(coordinates)"
           
           //create URL
           guard let url = URL(string: urlString) else {
               print ("ERROR: could not get URL from \(urlString)")
               completed()
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
                    let response = try JSONDecoder().decode(Result.self, from: data!)
                    self.timezone = response.timezone
                    self.currentTime = response.currently.time
                    self.temperature = Int(response.currently.temperature.rounded())
                    self.summary = response.daily.summary
                    self.dailyIcon = response.daily.icon
                    for index in 0..<response.daily.data.count {
                        let weekdayDate = Date(timeIntervalSince1970: response.daily.data[index].time)
                        dateFormatter.timeZone = TimeZone(identifier: response.timezone)
                        let dailyWeekday = dateFormatter.string(from: weekdayDate)
                        let dailyIcon = response.daily.data[index].icon
                        let dailySummary = response.daily.data[index].summary
                        let dailyHigh = Int(response.daily.data[index].temperatureHigh.rounded())
                        let dailyLow = Int(response.daily.data[index].temperatureLow.rounded())
                        let dailyWeather = DailyWeatherData(dailyIcon: dailyIcon, dailyWeekday: dailyWeekday, dailySummary: dailySummary, dailyHigh: dailyHigh, dailyLow: dailyLow)
                        self.dailyWeatherData.append(dailyWeather)
                        print("Date: \(dailyWeather.dailyWeekday) High: \(dailyWeather.dailyHigh) Low: \(dailyWeather.dailyLow)")
                    }
               } catch {
                    print("JSON ERROR: \(error.localizedDescription)")
               }
               completed()
           }
           
           task.resume()
       } 
 }
