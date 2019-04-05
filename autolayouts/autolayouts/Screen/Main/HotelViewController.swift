//
//  HotelViewController.swift
//  autolayouts
//
//  Created by Мария on 05/04/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit

class HotelViewController: UIViewController {
    @IBOutlet private var heightConstraint: NSLayoutConstraint!
    @IBOutlet private var selectButton: UIButton!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let height = CGFloat(selectButton.frame.origin.y + selectButton.frame.size.height) + 80
        heightConstraint.constant = height
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
