//
//  ImageView.swift
//  Rick-and-Morty
//
//  Created by Mordvintseva Alena on 24/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    func getImageByURL(url: URL) {
        let processor = DownsamplingImageProcessor(size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        self.kf.cancelDownloadTask()
        self.kf.setImage(with: url, options: [.processor(processor)])
    }
}
