//
//  NewCityController.swift
//  MayWeather
//
//  Created by Mayara Felix on 2017-12-16.
//  Copyright © 2017 maylcf. All rights reserved.
//

import UIKit
import CoreData

class NewCityController: UITableViewController, UISearchBarDelegate, GeonamesApiDelegate
{
    let mGeonamesManager = GeonamesApiManager()
    var mCities : [JSON]?
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-r=-=-=- //
    // View Controller
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mGeonamesManager.delegate = self;
        setTableBackground()
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
        return self.mCities?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cities = mCities
        {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "NewCityCell", for: indexPath)

            cell.selectedBackgroundView = self.getCellBackgroundColor()
            cell.textLabel?.text = cities[indexPath.row]["name"].string
            cell.detailTextLabel?.text = cities[indexPath.row]["countryName"].string
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.addNewCity(cityIndex: indexPath.row)
    }
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    // SearchBar
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        self.mGeonamesManager.getCitiesByName(cityName: searchText)
    }
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    // GeonamesApiDelegate
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
    
    func didFinishWithData(result: [JSON])
    {
        mCities = result
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
    
    func addNewCity(cityIndex: Int)
    {
        if let cityList = mCities
        {
            if let cityId = cityList[cityIndex]["geonameId"].int
            {
                if (!CityManager.cityExistsOnDatabase(cityId: cityId))
                {
                    CityManager.addNewCity(json: cityList[cityIndex])
                    navigationController?.popViewController(animated: true)
                }
                else
                {
                    let alert = AlertManager.getCityAlreadyExistsAlert()
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
} //class
