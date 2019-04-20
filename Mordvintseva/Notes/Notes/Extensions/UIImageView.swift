//
//  UIImageView.swift
//  Notes
//
//  Created by Mordvintseva Alena on 13/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import UIKit

extension UIImageView {
    func saveImage() -> String? {
        guard let image = self.image else {
            return nil
        }

        let fileManager = FileManager.default
        let dateString = DateService().getDate()
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(dateString)
        let data = image.jpegData(compressionQuality: 0.75)
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
        return imagePath
    }

    func getImage(path: String) {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: path) {
            self.image = UIImage(contentsOfFile: path)
        } else {
            print("No image. Path: \(path)")
        }
    }
}
