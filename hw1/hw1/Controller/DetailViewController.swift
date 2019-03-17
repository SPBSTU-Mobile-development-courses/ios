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
    @IBOutlet private var heightLabel: UILabel!
    @IBOutlet private var nameLable: UILabel!
    var person: Person?
    var avatar: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let person = person else { return }
        nameLable.text = "Name: \(person.name)"
        heightLabel.text = "Height: \(person.height)"
        avatarView.image = avatar
    }
}
