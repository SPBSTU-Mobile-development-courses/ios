//
//  CountryCell.swift
//  NewsAPI
//
//  Created by Никита Фролов  on 28.04.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import UIKit


class CountryCell:UITableViewCell {
    @IBOutlet var countryLabel:UILabel!
    
    func insert(string:String) {
        countryLabel.text = string
    }
}
