//
//  DetailViewController.swift
//  swapi_app
//
//  Created by Andrew on 21/04/2019.
//  Copyright © 2019 SPbSTU. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var hairLabel: UILabel!
    @IBOutlet weak var skinLabel: UILabel!
    @IBOutlet weak var eyeLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    var person: Person?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = person?.name
        heightLabel.text = person?.height
        massLabel.text = person?.mass
        hairLabel.text = person?.hairColor
        skinLabel.text = person?.skinColor
        eyeLabel.text = person?.eyeColor
        birthLabel.text = person?.birthYear
        genderLabel.text = person?.gender
    }
}
