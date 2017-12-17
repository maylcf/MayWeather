//
//  City+CoreDataProperties.swift
//  MayWeather
//
//  Created by Mayara Felix on 2017-12-16.
//  Copyright © 2017 maylcf. All rights reserved.
//
//

import Foundation
import CoreData


extension City
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<City>
    {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var country_name: String?
    @NSManaged public var city_name: String?
    @NSManaged public var country_code: String?

}
