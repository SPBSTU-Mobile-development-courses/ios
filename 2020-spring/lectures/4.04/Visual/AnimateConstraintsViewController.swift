//
//  AnimateConstraintsViewController.swift
//  Visual
//
//  Created by Anton Nazarov on 20/04/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

class AnimateConstraintsViewController: UIViewController {
    @IBOutlet private var constraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateConstraint))
        view.addGestureRecognizer(gestureRecognizer)
    }

    @objc func animateConstraint() {
        let offset: CGFloat = constraint.constant == 0 ? 300 : 0
        self.constraint.constant = offset
        UIView.animate(withDuration: 3) {
            self.view.layoutIfNeeded()
        }
    }
}
