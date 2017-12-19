//
//  ForecastController.swift
//  MayWeather
//
//  Created by Mayara Felix on 2017-12-16.
//  Copyright © 2017 maylcf. All rights reserved.
//

import UIKit

class ForecastController: UITableViewController, OpenWeatherDelegate
{
    var mWeeklyForecast = [DailyForecast]()
    var mJsonReturn : JSON?
    var mCity : City?
    var mWeatherManader = OpenWeatherManager()
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-r=-=-=- //
    // View Controller
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setTableBackground()
        mWeatherManader.delegate = self
        mWeatherManader.getWeeklyForecast(lat: mCity?.latitude, lon: mCity?.longitude)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    // TableView
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.mWeeklyForecast.count 
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as? ForecastCellController
        {
            cell.setCell(dailyForecast: mWeeklyForecast[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    // Delegate
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    
    func weatherSearchDidFinishWith(result: JSON, rowIndex: IndexPath?)
    {
        self.mJsonReturn = result
        populateArrayOfForecasts(jsonArray: result["list"].arrayValue)
        tableView.reloadData()
    }
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    // Custom Functions
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    
    func setTableBackground()
    {
        let imageView = UIImageView(image: UIImage(named: "background2"))
        imageView.alpha = 0.7
        self.tableView.backgroundView = imageView;
        //self.tableView.separatorColor = UIColor(red:0.00, green:0.41, blue:0.75, alpha:0.5)
    }
    
    func getCellBackgroundColor() -> UIView
    {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.00, green:0.41, blue:0.75, alpha:0.5)
        return view
    }
    
    func populateArrayOfForecasts(jsonArray: [JSON]?)
    {
        if let jsonArray = jsonArray
        {
            var count = 0
            for json in jsonArray
            {
                let forecast = DailyForecast(json: json)
                mWeeklyForecast.insert(forecast, at: count)
                count = count + 1
            }
        }
    }
}
