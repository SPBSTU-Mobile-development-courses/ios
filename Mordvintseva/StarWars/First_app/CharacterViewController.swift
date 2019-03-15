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
    private let personalFeatureCellIdentifier = "personalFeature"
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var character: Character!

    private enum PersonalFeatures: Int, CaseIterable {
        case height = 0
        case mass, hairColor, skinColor, eyeColor, birthYear, gender
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
        guard let num = PersonalFeatures(rawValue: indexPath.row) else { return cell }
        let value: String

        switch num {
        case .height:
            value = self.character.height
        case .mass:
            value = self.character.mass
        case .hairColor:
            value = self.character.hair_color
        case .skinColor:
            value = self.character.skin_color
        case .eyeColor:
            value = self.character.eye_color
        case .birthYear:
            value = self.character.birth_year
        case .gender:
            value = self.character.gender
        }

        cell.textLabel?.text = String(describing: num)
        cell.detailTextLabel?.text = value
        return cell
    }
}
