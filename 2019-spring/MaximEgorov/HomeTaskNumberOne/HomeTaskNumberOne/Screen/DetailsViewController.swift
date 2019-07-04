//
//  DetailsViewController.swift
//  HomeTaskNumberOne
//
//  Created by Максим Егоров on 13/03/2019.
//  Copyright © 2019 Максим Егоров. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var temperatureCelciusLabel: UILabel!
    @IBOutlet private var temperatureFarenheitLabel: UILabel!
    @IBOutlet private var windMphLabel: UILabel!
    @IBOutlet private var windKphLabel: UILabel!
    @IBOutlet private var windDirectionLabel: UILabel!
    @IBOutlet private var humidityLabel: UILabel!
    @IBOutlet private var cloudLabel: UILabel!
    @IBOutlet private var feelsLikeCelciusLabel: UILabel!
    @IBOutlet private var feelsLikeFarenheitLabel: UILabel!

    private let weatherService = WeatherServiceNetwork()
    var values: [String] = []
    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherService.getImage(url: url ?? "", sender: self.icon)
        temperatureCelciusLabel.text = values[0] + "º"
        temperatureFarenheitLabel.text = values[1]
        windMphLabel.text = values[2]
        windKphLabel.text = values[3]
        windDirectionLabel.text = values[4]
        humidityLabel.text = values[5]
        cloudLabel.text = values[6]
        feelsLikeCelciusLabel.text = values[8]
        feelsLikeFarenheitLabel.text = values[7]
    }
}
