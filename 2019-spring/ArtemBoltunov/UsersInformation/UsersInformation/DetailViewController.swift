//
//  DetailViewController.swift
//  UsersInformation
//
//  Created by Artem on 24/03/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet private var labelName: UILabel!
    @IBOutlet private var labelAge: UILabel!
    @IBOutlet private var labelGender: UILabel!
    @IBOutlet private var labelMass: UILabel!
    @IBOutlet private var labelHeight: UILabel!
    // swiftlint:disable:next implicitly_unwrapped_optional
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        labelName.text = user.name
        labelAge.text = user.age
        labelGender.text = user.gender
        labelMass.text = user.mass
        labelHeight.text = user.height
    }
}
