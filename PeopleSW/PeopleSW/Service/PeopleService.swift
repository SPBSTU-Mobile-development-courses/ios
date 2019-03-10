//
//  CurrencyService.swift
//  CurrencyConverter
//
//  Created by Anton Nazarov on 09/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

protocol PeopleService {
    func getPeoples(_ completionHandler: @escaping (([People]) -> Void))
}
