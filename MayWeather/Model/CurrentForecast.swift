//
//  CurrentForecast.swift
//  MayWeather
//
//  Created by Mayara Felix on 2017-12-18.
//  Copyright © 2017 maylcf. All rights reserved.
//

import Foundation

class CurrentForecast: Forecast
{
    var temperature: Int?
    
    init(json: JSON)
    {
        super.init()
        
        cityName = json["name"].string
        countryName = json["name"].string
        temperature = json["main"]["temp"].int
        timeStamp = json["dt"].double
        weatherIconCode = json["weather"][0]["icon"].string
        weatherDescription = json["weather"][0]["description"].string
    }
    
    func getTemperature() -> String
    {
        return (temperature != nil ? "\(temperature!)°" : "" )
    }
}
