//
//  UIApplication.swift
//  autolayouts
//
//  Created by Мария on 07/04/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit

extension UIApplication {
    static var appDelegate: AppDelegate {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("UIApplication delegate hasn't installed")
        }
        return appDelegate
    }
}
