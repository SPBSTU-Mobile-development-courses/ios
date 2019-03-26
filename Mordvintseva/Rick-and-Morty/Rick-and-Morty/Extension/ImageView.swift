//
//  ImageView.swift
//  Rick-and-Morty
//
//  Created by Mordvintseva Alena on 24/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func getImageByURL(url: URL, size: CGSize) {
        let processor = DownsamplingImageProcessor(size: size)
        self.kf.setImage(with: url, options: [.processor(processor)])
    }
}
