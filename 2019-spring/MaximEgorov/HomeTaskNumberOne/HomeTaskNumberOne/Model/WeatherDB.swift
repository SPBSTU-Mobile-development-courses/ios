//
//  WeatherInCell.swift
//  HomeTaskNumberOne
//
//  Created by Максим Егоров on 19/03/2019.
//  Copyright © 2019 Максим Егоров. All rights reserved.
//

import Foundation
import RealmSwift

final class WeatherDB: Object {
    @objc dynamic var cityName = ""
    @objc dynamic var imagePath = ""
    @objc dynamic var temperatureCelcius = 0
    @objc dynamic var temperatureFarenheit = 0.0
    @objc dynamic var windMph = 0.0
    @objc dynamic var windKph = 0.0
    @objc dynamic var windDirection = ""
    @objc dynamic var humidity = 0
    @objc dynamic var cloud = 0
    @objc dynamic var feelsLikeCelcius = 0.0
    @objc dynamic var feelsLikeFarenheit = 0.0
    @objc dynamic var text = ""
    @objc dynamic var createdAt = Date()
}
