//
//  InfoWordTableViewCell.swift
//  Dictionary
//
//  Created by Мария on 22/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//

import UIKit

class WordHeaderView: UITableViewHeaderFooterView {
    @IBOutlet private var wordTitleLabel: UILabel!
    @IBOutlet private var wordTypeLabel: UILabel!
    @IBOutlet private var phoneticSpellingLabel: UILabel!
    
    var entry: LexicalEntry? {
        didSet {
            wordTitleLabel.text = entry?.text
            wordTypeLabel.text = entry?.lexicalCategory
            guard let spelling = entry?.pronunciations?.first?.phoneticSpelling else {
                phoneticSpellingLabel.text = ""
                return
            }
            phoneticSpellingLabel.text = "\\\(spelling)\\"
        }
    }
}
