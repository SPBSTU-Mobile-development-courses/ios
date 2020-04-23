//
//  MemeCell.swift
//  Memes
//
//  Created by panandafog on 20.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import Kingfisher
import UIKit

class MemeCell: UITableViewCell {
    static var viewController: UIViewController?

    @IBOutlet private var label: UILabel!
    @IBOutlet private var picture: SelfScalingUIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        picture.image = nil
        picture.kf.cancelDownloadTask()
    }

    func setup(with meme: Post, controller: ViewController, index: IndexPath) {
        label.text = meme.title
        guard let url = meme.images?[0].url else { return }
        picture.kf.setImage(with: url) { result in
            switch result {
            case .success(let value):
                if value.cacheType != .memory {
                    controller.updateCell(row: index.row, section: index.section)
                }
            case .failure(let error):
                print(error)
                controller.updateCell(row: index.row, section: index.section)
            }
        }
    }
}
