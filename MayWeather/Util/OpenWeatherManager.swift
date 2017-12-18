//
//  WeatherSearch.swift
//  Weather Application Swift
//
//  Created by Mayara Felix on 2017-10-30.
//

import Foundation

class OpenWeatherManager
{
    var delegate : OpenWeatherDelegate?
    let apiKey = "9b665bd87411faf82fe8be2fac791020"
    let unitSystem = "metric"
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    // Methods
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    
    func getCurrentWeather(cityName: String, rowIndex: IndexPath)
    {
        let baseURL = "http://api.openweathermap.org/data/2.5/weather"
        let filters = "?q=\(cityName)&appid=\(apiKey)&units=\(unitSystem)"
        let strUrl = baseURL + filters
        print(strUrl)
        
        if let myUrl = URL(string: strUrl)
        {
            DispatchQueue.main.async
            {
                do
                {
                    let dataFromUrl = try String(contentsOf: myUrl, encoding: String.Encoding.utf8)
                    let data = dataFromUrl.data(using: .utf8)!
                    let json = JSON(data)
                    
                    DispatchQueue.main.async
                        {
                            self.delegate?.weatherSearchDidFinishWith(result: json, rowIndex: rowIndex)
                    }
                }
                catch
                {
                    print(error)
                }
            }
        }
    }
    
    func getCurrentWeather(lat: String?, lon: String?, rowIndex: IndexPath)
    {
        if let latitude = lat, let longitude = lon
        {
            let baseURL = "http://api.openweathermap.org/data/2.5/weather?"
            let filters = "lat=\(latitude)&lon=\(longitude)&units=\(unitSystem)&appid=\(apiKey)"
            let strUrl = baseURL + filters
            print(strUrl)
        
            if let myUrl = URL(string: strUrl)
            {
                DispatchQueue.main.async
                    {
                        do
                        {
                            let dataFromUrl = try String(contentsOf: myUrl, encoding: String.Encoding.utf8)
                            let data = dataFromUrl.data(using: .utf8)!
                            let json = JSON(data)
                            
                            DispatchQueue.main.async
                                {
                                    self.delegate?.weatherSearchDidFinishWith(result: json, rowIndex: rowIndex)
                            }
                        }
                        catch
                        {
                            print(error)
                        }
                }
            }
        }
    }
    
//    func getWeather(cityName : String)
//    {
//        let baseURL     = "http://api.openweathermap.org/data/2.5/weather"
//        let weatherCode = "9b665bd87411faf82fe8be2fac791020"
//
//        let filters = "?q=\(cityName)&appid=\(weatherCode)&units=\(unitSystem)"
//        let strUrl = baseURL + filters
//        print(strUrl)
//        let myUrl = URL(string: strUrl)
//
//        DispatchQueue.main.async
//        {
//            if let url = myUrl
//            {
//                do
//                {
//                    let dataFromUrl = try String(contentsOf: url, encoding: String.Encoding.utf8)
//                    let data = dataFromUrl.data(using: .utf8)!
//                    let json = JSON(data)
//
//                    DispatchQueue.main.async
//                    {
//                        self.delegate?.weatherSearchDidFinishWith(result: json)
//                    }
//                }
//                catch
//                {
//                    print(error)
//                }
//            }
//        }
//    }
    
//    func getForecast(cityName : String)
//    {
//        if let url = WeatherSearch.getForecastWeatherURL(city: cityName)
//        {
//            DispatchQueue.main.async
//            {
//                do
//                {
//                    let dataFromUrl = try String(contentsOf: url, encoding: String.Encoding.utf8)
//                    let data = dataFromUrl.data(using: .utf8)!
//                    let json = JSON(data)
//                    
//                    DispatchQueue.main.async
//                    {
//                        self.delegate?.weatherSearchDidFinishWith(result: json)
//                    }
//                }
//                catch
//                {
//                    print(error)
//                }
//            }
//        }
//    }
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    // Class Methods
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    
    class func getWeatherIconURL(iconCode: String) -> URL?
    {
        let urlString = "http://openweathermap.org/img/w/\(iconCode).png"
        
        return URL(string: urlString)
    }
    
    class func getIconName(json : JSON) -> String
    {
        let jsonArray = json["weather"].arrayValue
        let iconName = jsonArray[0]["icon"].stringValue
        return iconName
    }
    
    class func getForecastWeatherURL(city: String) -> URL?
    {
        var urlString = "http://api.openweathermap.org/data/2.5/forecast/daily?q=\(city)"
        urlString = urlString + "&mode=json&units=metric&cnt=7&APPID=acebdb4548ced12a28df4ccf585c3466"
        
        print("Forecast URL = \(urlString)")
        
        return URL(string: urlString)
    }
    
}

protocol OpenWeatherDelegate
{
    func weatherSearchDidFinishWith(result : JSON, rowIndex: IndexPath);
}
