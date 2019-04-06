//
//  UIViewExtension.swift
//  autolayouts
//
//  Created by Мария on 07/04/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var isRounded: Bool {
        get {
            return self.isRounded
        }
        set {
            layer.cornerRadius = newValue ? frame.size.height / 6 : 0
        }
    }
    
    func make(withCorner radius: CGFloat) {
        layer.cornerRadius = radius
    }
}
