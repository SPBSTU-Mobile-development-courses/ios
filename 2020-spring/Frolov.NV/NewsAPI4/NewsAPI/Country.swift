//
//  Country.swift
//  NewsAPI
//
//  Created by Никита Фролов  on 24.04.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import Foundation

final class Country {
    public var countryName:String
    public var countyForUrl:String
    
    init(name: String, url:String) {
        countryName = name
        countyForUrl = url
    }
}
