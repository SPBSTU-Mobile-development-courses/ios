//
//  RoundButton.swift
//  autolayouts
//
//  Created by Мария on 05/04/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton: UIButton {
    @IBInspectable private var isRounded: Bool = false {
        didSet {
            guard isRounded else { return }
            layer.cornerRadius = frame.size.height / 6
        }
    }
}
