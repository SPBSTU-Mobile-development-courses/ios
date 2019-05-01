//
//  UITableView.swift
//  Notes
//
//  Created by Mordvintseva Alena on 14/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
