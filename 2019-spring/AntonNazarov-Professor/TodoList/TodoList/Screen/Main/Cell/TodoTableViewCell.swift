//
//  TodoTableViewCell.swift
//  TodoList
//
//  Created by Anton Nazarov on 17/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

final class TodoTableViewCell: UITableViewCell {
    @IBOutlet private var messageLabel: UILabel!

    var todo: Todo? {
        didSet {
            messageLabel.text = todo?.message
        }
    }
}
