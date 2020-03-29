//
//  WordDetailedTableViewCell.swift
//  Dictionary
//
//  Created by Мария on 23/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    @IBOutlet private var definitionTextView: UITextView!
    @IBOutlet private var exampleTextView: UITextView!

    func setCellAt(indexPath: IndexPath, with sense: Sense?) {
        let definition = sense?.definitions?.first ?? sense?.shortDefinitions?.first ?? "No definition"
        definitionTextView.text = "\(indexPath.row + 1). \(definition):\n"
        exampleTextView.text = sense?.examples?.first?.text ?? "No example"
    }
}
