//
//  DailyForecast.swift
//  MayWeather
//
//  Created by Mayara Felix on 2017-12-18.
//  Copyright © 2017 maylcf. All rights reserved.
//

import Foundation

class DailyForecast: Forecast
{
    var maxTemp: Int?
    var minTemp: Int?
    
    init(json: JSON)
    {
        super.init()
        
        timeStamp = json["dt"].double
        maxTemp = json["temp"]["max"].int
        minTemp = json["temp"]["min"].int
        weatherIconCode = json["weather"][0]["icon"].string
        weatherDescription = json["weather"][0]["description"].string
    }
    
    func getMaxTemp() -> String
    {
        return (maxTemp != nil ? "\(maxTemp!)°" : "" )
    }
    
    func getMinTemp() -> String
    {
        return (minTemp != nil ? "\(minTemp!)°" : "" )
    }
}
