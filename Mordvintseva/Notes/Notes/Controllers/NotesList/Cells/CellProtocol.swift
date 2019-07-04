//
//  CellProtocol.swift
//  Notes
//
//  Created by Mordvintseva Alena on 01/05/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation
import Reusable
import UIKit

protocol CellProtocol: NibReusable {
    func setInfo(note: Note)
}
