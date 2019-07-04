//
//  Note.swift
//  Notes
//
//  Created by Mordvintseva Alena on 12/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    @objc dynamic var title = ""
    @objc dynamic var text = ""
    @objc dynamic var imagePath = ""
    @objc dynamic var created = Date()

    convenience init(data: [String: String]) {
        self.init()
        if let title = data["title"] {
            self.title = title
        }
        if let text = data["text"] {
            self.text = text
        }
        if let imagePath = data["imagePath"] {
            self.imagePath = imagePath
        }
    }
}
