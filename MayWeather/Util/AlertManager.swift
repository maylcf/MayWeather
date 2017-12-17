//
//  AlertManager.swift
//  MayWeather
//
//  Created by Mayara Felix on 2017-12-17.
//  Copyright © 2017 maylcf. All rights reserved.
//

import UIKit

class AlertManager
{
    static func getCityAlreadyExistsAlert() -> UIAlertController
    {
        let message = "You alread have this city in your list."
        let title = "City Already Exists"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        return alert
    }
}
