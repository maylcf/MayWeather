//
//  Forecast.swift
//  MayWeather
//
//  Created by Mayara Felix on 2017-12-17.
//  Copyright © 2017 maylcf. All rights reserved.
//

import UIKit

class Forecast
{
    var cityName: String?
    var countryName: String?
    var weatherDescription: String?
    var weatherIconCode: String?
    var temperature: Int?
    var timeStamp: Int?
    
    init(json: JSON)
    {
        cityName = json["name"].string
        countryName = json["name"].string
        temperature = json["main"]["temp"].int
        timeStamp = json["dt"].int
        weatherIconCode = json["weather"][0]["icon"].string
        weatherDescription = json["weather"][0]["description"].string
    }
    
    func getTemperature() -> String
    {
        return (temperature != nil ? "\(temperature!)°C" : "" )
    }
    
    func getIconImage() -> UIImage?
    {
        if let iconName = weatherIconCode
        {
            return UIImage(named: iconName)
        }
        return nil
    }
}
