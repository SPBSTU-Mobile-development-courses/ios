//
//  MainView.swift
//  UsersInformation
//
//  Created by Artem on 20/03/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    @IBOutlet private var labelName: UILabel!
    @IBOutlet private var labelAge: UILabel!
    @IBOutlet private var labelGender: UILabel!
    @IBOutlet private var labelMass: UILabel!
    @IBOutlet private var labelHeight: UILabel!

    private let authStatus = "authStatus"
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

    @IBAction private func clickLogOutButton(_ sender: UIButton) {
        UserDefaults.standard.set("unautorized", forKey: authStatus)
    }
}
