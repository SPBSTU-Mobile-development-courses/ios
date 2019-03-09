//
//  CurrencyServiceNetwork.swift
//  CurrencyConverter
//
//  Created by Anton Nazarov on 09/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import Alamofire
import Foundation

class CurrencyServiceNetwork: CurrencyService {
    //    func getCurrencies(_ completionHandler: @escaping (([Currency]) -> Void)) {
    //        let url = URL(string: "http://data.fixer.io/api/latest?access_key=ea50066730ed2d2d16a9d0d8182d7dbb")!
    //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //            if let error = error {
    //                print("Error: \(error)")
    //                return
    //            }
    //            let jsonDecoder = JSONDecoder()
    //            let rates = try! jsonDecoder.decode(Rates.self, from: data!)
    //            let currencies = rates.rates.map { (keyValue) -> Currency in
    //                let (name, rate) = keyValue
    //                return Currency(name: name, rate: rate)
    //            }
    //            completionHandler(currencies)
    //        }
    //        task.resume()
    //    }

    func getCurrencies(_ completionHandler: @escaping (([Currency]) -> Void)) {
        request("http://data.fixer.io/api/latest?access_key=ea50066730ed2d2d16a9d0d8182d7dbb").responseData {
            switch $0.result {
            case let .success(data):
                let jsonDecoder = JSONDecoder()
                let rates = try? jsonDecoder.decode(Rates.self, from: data)
                let currencies = rates?.rates.map { keyValue -> Currency in
                    let (name, rate) = keyValue
                    return Currency(name: name, rate: rate)
                }
                completionHandler(currencies ?? [])
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
