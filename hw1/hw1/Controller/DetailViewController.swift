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
    var people: Person?
    var avatar: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = people?.name {
            nameLable.text = "Name: \(name)"
        }
        if let height = people?.height {
            heightLabel.text = "Height: \(height)"
        }
        if let avatar = avatar {
            avatarView.image = avatar
        }
    }
}
