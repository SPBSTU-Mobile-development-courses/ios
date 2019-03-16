//
//  WeatherService.swift
//  
//
//  Created by Максим Егоров on 11/03/2019.
//

import Foundation
import Alamofire

protocol WeatherService {
    getCurrentWeather(_ completionHandler: @escaping (([Weather]) -> Void))
}
