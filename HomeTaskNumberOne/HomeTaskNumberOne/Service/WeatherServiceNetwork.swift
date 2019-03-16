////
////  WeatherServiceNetwork.swift
////  HomeTaskNumberOne
////
////  Created by Максим Егоров on 11/03/2019.
////  Copyright © 2019 Максим Егоров. All rights reserved.
////
//
//import Foundation
//import UIKit
//import Alamofire
//
//class WeatherServiceNetwork: WeatherService {
//
//
//    func getCurrentWeather(location: String, _ completionHandler: @escaping ((Values) -> Void)) {
//
//        let url = "http://api.apixu.com/v1/current.json?key=94f1763d0042416fa7b141450191103&q=\(location)"
//
//        request(url).responseData{
//
//            switch $0.result {
//            case let .success(data):
//                var value = Values()
//                guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject]
//                else{
//                    return
//                }
//
//                if let location = json["location"]{
//                    value.location = location["name"] as? String ?? "eveve"
//                }
//
//                if let current = json["current"]{
//                    value.currentTemperatureCelsius = current["temp_c"] as? Double ?? -100
//                    value.currentTemperatureFahrenheit = (current["temp_f"] as? Double) ?? -100
//                    value.currenWindOfSpeed = (current["wind_kph"] as? Double) ?? -100
//                    value.currentWindDirection = current["wind_dir"] as? Double ?? -100
//
//                    if let condition = current["condition"]{
//                        value.conditionDescribe = condition["text"] as? String ?? ""
//                        value.conditionIcon = condition["icon"] as? UIImage ?? UIImage()
//                    }
//                }
//            completionHandler(value)
//
//            case let .failure(error):
//                print("Error: \(error)")
//            }
//    }
//}
//}
