//
//  CityCellController.swift
//  MayWeather
//
//  Created by Mayara Felix on 2017-12-17.
//  Copyright © 2017 maylcf. All rights reserved.
//

import UIKit

class CityCellController: UITableViewCell
{
    @IBOutlet weak var mCityName: UILabel!
    @IBOutlet weak var mCountryName: UILabel!
    @IBOutlet weak var mWeatherIcon: UIImageView!
    @IBOutlet weak var mTemperature: UILabel!
    
    func setCity(city: City)
    {
        mCityName.text = city.city_name
        mCountryName.text = city.country_name
        
        mCityName.textColor = UIColor(red:0.96, green:1.00, blue:0.98, alpha:1.0)
        mCountryName.textColor = UIColor.white
    }
    
    func setWeather(forecast: Forecast)
    {
        mWeatherIcon.image = forecast.getIconImage()
        mTemperature.text = forecast.getTemperature()
        
        mTemperature.textColor = UIColor.white
    }
}
