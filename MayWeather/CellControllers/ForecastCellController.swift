//
//  ForecastCellController.swift
//  MayWeather
//
//  Created by Mayara Felix on 2017-12-17.
//  Copyright © 2017 maylcf. All rights reserved.
//

import UIKit

class ForecastCellController: UITableViewCell
{
    @IBOutlet weak var mDayOfWeek: UILabel!
    @IBOutlet weak var mDayOfMonth: UILabel!
    
    @IBOutlet weak var mWeatherIcon: UIImageView!
    @IBOutlet weak var mWeatherDesc: UILabel!
    
    @IBOutlet weak var mMaxTemperature: UILabel!
    @IBOutlet weak var mMinTemperature: UILabel!
    
    func setCell(dailyForecast: DailyForecast)
    {
        mWeatherIcon.image = dailyForecast.getIconImage()
        mDayOfWeek.text = DateHandle.getWeekDay(numOfSecs: dailyForecast.timeStamp!)
        mDayOfMonth.text = DateHandle.getLongDate(numOfSecs: dailyForecast.timeStamp!)
        mWeatherDesc.text = dailyForecast.weatherDescription
        mMaxTemperature.text = dailyForecast.getMaxTemp()
        mMinTemperature.text = dailyForecast.getMinTemp()
    }
}

