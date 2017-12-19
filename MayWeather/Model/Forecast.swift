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
    //var temperature: Int?
    var timeStamp: Double?
    
    init() { }
    
    func getIconImage() -> UIImage?
    {
        if let iconName = weatherIconCode
        {
            return UIImage(named: iconName)
        }
        return nil
    }
}
