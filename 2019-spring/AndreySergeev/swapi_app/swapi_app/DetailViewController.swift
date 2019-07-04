//
//  DetailViewController.swift
//  swapi_app
//
//  Created by Andrew on 02/05/2019.
//  Copyright © 2019 SPbSTU. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var skinColorLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = person?.name
        heightLabel.text = person?.height
        massLabel.text = person?.mass
        hairColorLabel.text = person?.hairColor
        skinColorLabel.text = person?.skinColor
        eyeColorLabel.text = person?.eyeColor
        birthYearLabel.text = person?.birthYear
        genderLabel.text = person?.gender
        switch person?.gender {
        case "male":
            avatarImage.image = UIImage(named: "avatar-male")
        case "female":
            avatarImage.image = UIImage(named: "female-avatar")
        default:
            avatarImage.image = UIImage(named: "generic-avatar")
        }
    }
}
