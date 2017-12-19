//
//  CityListController.swift
//  MayWeather
//
//  Created by Mayara Felix on 2017-12-16.
//  Copyright © 2017 maylcf. All rights reserved.
//

import UIKit
import CoreData

class CityListController: UITableViewController, OpenWeatherDelegate
{
    var mMyCities : [City]?
    var mWeatherManager = OpenWeatherManager()
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-r=-=-=- //
    // View Controller
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setTableBackground()
        mWeatherManager.delegate = self
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadCitiesFromDatabase()
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
        return self.mMyCities?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let myCitiesList = mMyCities
        {
            let city = myCitiesList[indexPath.row]
            mWeatherManager.getCurrentWeather(lat: city.latitude, lon: city.longitude, rowIndex: indexPath)

            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityCellController
            {
                cell.setCity(city: city)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            self.removeCity(cityIndex: indexPath.row)
        }
    }
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    // Delegate
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //

    func weatherSearchDidFinishWith(result: JSON, rowIndex: IndexPath?)
    {
        if let rowIndex = rowIndex
        {
            let forecast = CurrentForecast(json: result)
            
            if let cell = self.tableView.cellForRow(at: rowIndex) as? CityCellController
            {
                cell.setWeather(forecast: forecast)
            }
        }
    }
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    // Transition
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "WeeklyForecast"
        {
            if let vc = segue.destination as? ForecastController
            {
                if let cities = mMyCities, let index = self.tableView.indexPathForSelectedRow?.row
                {
                    vc.mCity = cities[index]
                }
            }
            
        }
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
        self.tableView.separatorColor = UIColor(red:0.96, green:1.00, blue:0.98, alpha:1.0)
    }
    
    func loadCitiesFromDatabase()
    {
        self.mMyCities = CityManager.selectAllCities()
        self.tableView.reloadData()
    }
    
    func removeCity(cityIndex: Int)
    {
        if let myCitiesList = mMyCities
        {
            let city = myCitiesList[cityIndex]
            
            let title = "Delete City"
            let message = "Do you really want to remove '\(String(describing: city.city_name)) - \(String(describing: city.country_name))' from your list?"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            let actionConfirm = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler:
            { action in
                
                CityManager.deleteStock(cityId: Int(city.id))
                self.tableView.reloadData()
            })
            
            alert.addAction(actionCancel)
            alert.addAction(actionConfirm)
            
            present(alert, animated: true, completion: nil)
        }
    }
}
