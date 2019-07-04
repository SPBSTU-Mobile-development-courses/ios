//
//  UITabBarControllerExtension.swift
//  autolayouts
//
//  Created by Мария on 05/04/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit

extension UITabBarController {
    func makeItem(atIndex index: Int, enable: Bool) {
        guard let items = tabBar.items else { return }
        items[index].isEnabled = enable
    }
}
