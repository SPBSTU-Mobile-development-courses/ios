//
//  CellController.swift
//  HomeTaskNumberOne
//
//  Created by Максим Егоров on 13/03/2019.
//  Copyright © 2019 Максим Егоров. All rights reserved.
//

import UIKit

class CellController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationLabel?.text = "Barcelona"
    }
    

}
