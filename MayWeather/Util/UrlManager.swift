//
//  UrlManager.swift
//  Weather Application Swift
//
//  Created by Mayara Felix on 2017-12-13.
//

import Foundation

class UrlManager
{
    static func getUrl(text: String) -> URL?
    {
        if let url = replaceSpaces(text: text)
        {
            return URL(string: url)
        }
        return nil
    }
    
    static func replaceSpaces(text: String) -> String?
    {
        if let newText = text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        {
            return newText
        }
        return nil
    }
}
