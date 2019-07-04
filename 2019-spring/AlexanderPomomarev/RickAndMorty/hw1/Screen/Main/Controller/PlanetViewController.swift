//
//  PlanetViewController.swift
//  hw1
//
//  Created by Александр Пономарёв on 23/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

import UIKit

class PlanetViewController: UIViewController {
    @IBOutlet private var namePlanetLabel: UILabel!
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var dimensionLabel: UILabel!
    var url: String?
    private let jsonDataService = JsonDataService()
    private var planet = [Planet]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let url = url else { return }
        self.jsonDataService.getPlanet(url: url) { [weak self] planet in
            guard let self = self else { return }
            self.planet.append(planet)
            DispatchQueue.main.async {
                self.namePlanetLabel.text = "Name: " + planet.name
                self.typeLabel.text = "Type: " + planet.type
                self.dimensionLabel.text = "Dimension: " + planet.dimension
            }
        }
    }
}
