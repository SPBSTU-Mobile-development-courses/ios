//
//  WeatherService.swift
//  HomeTaskNumberOne
//
//  Created by Максим Егоров on 15/03/2019.
//  Copyright © 2019 Максим Егоров. All rights reserved.
//

protocol WeatherService {
    func getCurrentWeather(location: String, _ completionHandler: @escaping ((Weather) -> Void))
}
