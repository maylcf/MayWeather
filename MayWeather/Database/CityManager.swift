//
//  CityManager.swift
//  MayWeather
//
//  Created by Mayara Felix on 2017-12-17.
//  Copyright © 2017 maylcf. All rights reserved.
//

import Foundation
import CoreData

class CityManager
{
    public class func getCity(json: JSON) -> City?
    {
        if let cityId = json["geonameId"].int
        {
            let city = City(context: PersistenceService.context)
            city.id = Int32(cityId)
            city.city_name = json["name"].stringValue
            city.country_name = json["countryName"].stringValue
            city.country_code = json["country"].stringValue
            city.longitude = json["lng"].stringValue
            city.latitude = json["lat"].stringValue
            
            return city
        }
        return nil
    }
    
    public class func addNewCity(json: JSON)
    {
        if getCity(json: json) != nil
        {
            PersistenceService.saveContext()
        }
    }
    
    public class func deleteStock(cityId: Int)
    {
        let fetchRequest: NSFetchRequest<City> = NSFetchRequest<City>(entityName: "City")
        let predicate = NSPredicate(format: "id = %d", cityId)
        fetchRequest.predicate = predicate
        
        do
        {
            let result = try PersistenceService.context.fetch(fetchRequest)
            
            for stock in result
            {
                PersistenceService.context.delete(stock)
                PersistenceService.saveContext()
            }
        }
        catch
        {
            print("[deleteStock] Error deleting stocks")
        }
    }
    
    public class func selectCityById(cityId: Int) -> City?
    {
        let fetchRequest: NSFetchRequest<City> = NSFetchRequest<City>(entityName: "City")
        let predicate = NSPredicate(format: "id = %d", cityId)
        fetchRequest.predicate = predicate
        
        var results: [City] = []
        
        do
        {
            results = try PersistenceService.context.fetch(fetchRequest)
        }
        catch
        {
            print("error executing fetch request: \(error)")
        }
        
        if results.count > 0
        {
            return results[0]
        }
        else
        {
            return nil
        }
    }
    
    public class func selectAllCities() -> [City]
    {
        let fetchRequest: NSFetchRequest<City> = NSFetchRequest<City>(entityName: "City")
        
        var results: [City] = []
        
        do
        {
            results = try PersistenceService.context.fetch(fetchRequest)
        }
        catch
        {
            print("error executing fetch request: \(error)")
        }
        
        return results
    }
    
    public class func cityExistsOnDatabase(cityId: Int) -> Bool
    {
        if selectCityById(cityId: cityId) != nil
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    
} //class
