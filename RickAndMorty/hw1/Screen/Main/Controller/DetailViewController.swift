//
//  DetailViewController.swift
//  hw1
//
//  Created by Александр Пономарёв on 13/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet private var avatarView: UIImageView!
    @IBOutlet private var genderLabel: UILabel!
    @IBOutlet private var nameLable: UILabel!
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var speciesLabel: UILabel!
    var realmPerson: RealmChar?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let realmPerson = realmPerson else { return }
        nameLable.text = "Name: \(realmPerson.name)"
        genderLabel.text = "Gender: \(realmPerson.gender)"
        statusLabel.text = "Status: \(realmPerson.status)"
        speciesLabel.text = "Species: \(realmPerson.species)"
        let url = URL(string: realmPerson.image)
        guard let urlNew = url else { return }
        self.avatarView.kf.setImage(with: urlNew)
    }
}
