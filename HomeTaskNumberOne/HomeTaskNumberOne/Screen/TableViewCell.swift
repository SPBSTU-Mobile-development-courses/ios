//
//  TableViewCell.swift
//  
//
//  Created by Максим Егоров on 15/03/2019.
//

import Kingfisher
import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var currentTempCLabel: UILabel!
    private let weatherService = WeatherServiceNetwork()

    func setCell(cityName: String, tempC: String, imagePath: String) {
        self.cityNameLabel.text = cityName
        self.currentTempCLabel.text = tempC
        weatherService.getImage(url: imagePath, sender: self.icon)
    }
}
