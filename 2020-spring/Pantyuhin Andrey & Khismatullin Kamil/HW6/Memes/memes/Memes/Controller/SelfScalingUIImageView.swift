//
//  SelfScalingUIImageView.swift
//  Memes
//
//  Created by panandafog on 31.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import UIKit

class SelfScalingUIImageView: UIImageView {
    override var intrinsicContentSize: CGSize {
        let frameSizeWidth = self.frame.size.width
        guard let image = self.image else {
            return CGSize(width: frameSizeWidth, height: 500)
        }
        let returnHeight = ceil(image.size.height * (frameSizeWidth / image.size.width))
        return CGSize(width: frameSizeWidth, height: returnHeight)
    }
}
