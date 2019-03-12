//
//  ViewController.swift
//  First_app
//
//  Created by Mordvintseva Alena on 10/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController, UITableViewDataSource {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var personalFeaturesTable: UITableView!
    let personalFeatureCellIdentifier = "personalFeature"
    private var character = Character()

    enum PersonalFeatures: Int, CaseIterable {
        case height = 0
        case mass, hair_color, skin_color, eye_color, birth_year, gender
    }

    func setCharacter(character: Character) {
        self.character = character
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = character.name
        self.personalFeaturesTable.dataSource = self
        DispatchQueue.main.async {
            self.personalFeaturesTable.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonalFeatures.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = personalFeaturesTable.dequeueReusableCell(withIdentifier: personalFeatureCellIdentifier, for: indexPath)
        let num: PersonalFeatures? = PersonalFeatures(rawValue: indexPath.row)
        var category = ""
        var value = ""
        if let num = num {
            switch num {
            case .height:
                value = self.character.height
            case .mass:
                value = self.character.mass
            case .hair_color:
                value = self.character.hair_color
            case .skin_color:
                value = self.character.skin_color
            case .eye_color:
                value = self.character.eye_color
            case .birth_year:
                value = self.character.birth_year
            case .gender:
                value = self.character.gender
            }
            category = String(describing: num)
        }

        cell.textLabel?.text = category
        cell.detailTextLabel?.text = value
        return cell
    }
}
