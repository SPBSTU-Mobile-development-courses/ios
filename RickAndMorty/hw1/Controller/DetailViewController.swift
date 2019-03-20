//
//  DetailViewController.swift
//  hw1
//
//  Created by Александр Пономарёв on 13/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

import Kingfisher
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet private var avatarView: UIImageView!
    @IBOutlet private var heightLabel: UILabel!
    @IBOutlet private var nameLable: UILabel!
    var realmPerson: RealmChar?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let realmPerson = realmPerson else { return }
        nameLable.text = "Name: \(realmPerson.name)"
        heightLabel.text = "Gender: \(realmPerson.gender)"
        let url = URL(string: realmPerson.image)
        guard let urlNew = url else { return }
        avatarView.kf.setImage(with: urlNew)
    }
}
