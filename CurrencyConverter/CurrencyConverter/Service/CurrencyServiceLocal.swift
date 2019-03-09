//
//  CurrencyServiceLocal.swift
//  CurrencyConverter
//
//  Created by Anton Nazarov on 09/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import Foundation

class CurrencyServiceLocal: CurrencyService {
    private static func json(named name: String) -> Data {
        guard let filePath = Bundle.main.path(forResource: name, ofType: "json") else {
            // swiftlint:disable:next force_unwrapping
            return "".data(using: String.Encoding.utf8)!
        }
        // swiftlint:disable:next force_try
        return try! Data(contentsOf: URL(fileURLWithPath: filePath))
    }

    func getCurrencies(_ completionHandler: (([Currency]) -> Void)) {
        let json = CurrencyServiceLocal.json(named: "currencies")
        let jsonDecoder = JSONDecoder()
        let rates = try? jsonDecoder.decode(Rates.self, from: json)
        let currencies = rates?.rates.map { keyValue -> Currency in
            let (name, rate) = keyValue
            return Currency(name: name, rate: rate)
        }
        completionHandler(currencies ?? [])
    }
}
