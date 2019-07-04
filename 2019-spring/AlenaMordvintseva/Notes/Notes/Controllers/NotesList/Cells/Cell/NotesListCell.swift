//
//  NotesListCell.swift
//  Notes
//
//  Created by Mordvintseva Alena on 23/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation
import Reusable
import UIKit

class NotesListCell: UITableViewCell, CellProtocol {
    @IBOutlet private var titleView: UILabel!
    @IBOutlet private var noteView: UILabel!

    func setInfo(note: Note) {
        titleView.text = note.title
        noteView.text = note.text
    }
}
