//
//  DateHandle.swift
//  Weather Application Swift
//
//  Created by Mayara Felix on 2017-10-30.
//

import Foundation

class DateHandle
{
    class func getWeekDay(numOfSecs : Double) -> String
    {
        let date = Date(timeIntervalSince1970: numOfSecs)
        let formatter = DateFormatter()
        
        //formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    
    class func getShortDate(numOfSecs : Double) -> String
    {
        let date = Date(timeIntervalSince1970: numOfSecs)
        let formatter = DateFormatter()
        
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        
        return formatter.string(from: date)
    }
    
    class func getLongDate(numOfSecs : Double) -> String
    {
        let date = Date(timeIntervalSince1970: numOfSecs)
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMMM dd"
        
        //formatter.locale = Locale(identifier: "en_US")
        //formatter.setLocalizedDateFormatFromTemplate("MMMMd")
        
        //formatter.dateStyle = DateFormatter.Style.long
        //formatter.timeStyle = DateFormatter.Style.none
        
        return formatter.string(from: date)
    }
    
    class func getCurrDate()
    {
        let currDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.short
        //formatter.dateFormat = "EEE, MMM, dd"
    }
    
    
}
