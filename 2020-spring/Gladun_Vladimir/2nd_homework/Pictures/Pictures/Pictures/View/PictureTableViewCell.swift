//
//  PictureTableViewCell.swift
//  Pictures
//
//  Created by Vladimir GL on 03.04.2020.
//  Copyright © 2020 VDTA. All rights reserved.
//

import UIKit

final class PictureTableViewCell: UITableViewCell {
  @IBOutlet private var nameLabel: UILabel!
  @IBOutlet private var avatarImageView: UIImageView!
  private var avatarLoadTask: URLSessionTask?
  
  override func prepareForReuse() {
    super.prepareForReuse()
    avatarImageView.image = nil
    avatarLoadTask?.cancel()
  }
  
  func setup(with picture: Image) {
    nameLabel.text = picture.user
    guard let imageUrl = picture.url else { return }
    avatarLoadTask = URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
      guard let data = data, let image = UIImage(data: data) else { return }
      DispatchQueue.main.async {
        self.avatarImageView.image = image
      }
    }
    avatarLoadTask?.resume()
  }
}
