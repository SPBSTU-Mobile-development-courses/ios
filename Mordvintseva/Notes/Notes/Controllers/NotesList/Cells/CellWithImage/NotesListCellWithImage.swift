//
//  NotesListCell.swift
//  Notes
//
//  Created by Mordvintseva Alena on 19/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation
import Reusable
import UIKit

class NotesListCellWithImage: UITableViewCell, CellProtocol {
    @IBOutlet private var titleView: UILabel!
    @IBOutlet private var noteView: UILabel!
    @IBOutlet private var noteImage: UIImageView!

    func setInfo(note: Note) {
        titleView.text = note.title
        noteView.text = note.text
        if note.imagePath.isEmpty != true {
            noteImage.image = ImageRepository().get(imagePath: note.imagePath)
        }
    }
}
