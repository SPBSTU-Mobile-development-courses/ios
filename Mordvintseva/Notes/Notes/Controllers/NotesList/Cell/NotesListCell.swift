//
//  NotesListCell.swift
//  Notes
//
//  Created by Mordvintseva Alena on 19/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation
import UIKit

class NotesListCell: UITableViewCell {
    @IBOutlet private var title: UILabel!
    @IBOutlet private var noteText: UILabel!
    @IBOutlet private var noteImage: UIImageView!
    @IBOutlet private var noteImageHeightConstraint: NSLayoutConstraint!

    func setInfo(note: Note) {
        title.text = note.title
        noteText.text = note.text
        if note.imagePath.isEmpty != true {
            noteImage.getImage(path: note.imagePath)
            noteImageHeightConstraint.constant = noteImage.frame.width * 3.0 / 4.0
        }
    }
}
