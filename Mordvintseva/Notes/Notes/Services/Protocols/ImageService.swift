//
//  ImageServiceProtocol.swift
//  Notes
//
//  Created by Mordvintseva Alena on 01/05/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation
import UIKit

protocol ImageService {
    func save(image: UIImage) -> String
    func get(imagePath: String) -> UIImage?
}
