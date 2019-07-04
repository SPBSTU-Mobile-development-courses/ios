//
//  WeatherServiceNetwork.swift
//  HomeTaskNumberOne
//
//  Created by Максим Егоров on 15/03/2019.
//  Copyright © 2019 Максим Егоров. All rights reserved.
//

import Alamofire
import Kingfisher

class WeatherServiceNetwork: WeatherService {
    func getCurrentWeather(location: String, _ completionHandler: @escaping ((Weather) -> Void)) {
        let url = "http://api.apixu.com/v1/current.json?key=94f1763d0042416fa7b141450191103&q=\(location)"
        request(url).responseData {
            switch $0.result {
            case let .success(data):
                let jsonDecoder = JSONDecoder()
                guard let weather = try? jsonDecoder.decode(Weather.self, from: data) else {
                    return
                }
                completionHandler(weather)
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }

    func getImage(url: String, sender: UIImageView) {
        let https = "https:"
        let urlRequest = URL(string: https + url)
        sender.kf.setImage(with: urlRequest)
    }
}
