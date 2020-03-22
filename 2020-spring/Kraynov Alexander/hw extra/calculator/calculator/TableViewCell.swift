//
//  tableViewCell.swift
//  calculator
//
//  Created by Admin on 22.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import UIKit

final class TableViewCell: UITableViewCell {
    @IBOutlet private var textInside: UILabel!
    
    func setup (text: String)
    {
        textInside.text = text
    }
}
