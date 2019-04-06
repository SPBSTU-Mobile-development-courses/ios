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
    private enum Const {
        static let bottomIndent: CGFloat = 80
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = CGFloat(selectButton.frame.origin.y + selectButton.bounds.size.height) + Const.bottomIndent
        heightConstraint.constant = height
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
