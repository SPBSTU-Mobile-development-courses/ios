//
//  CharacterTableViewCell.swift
//  HomeWork2
//
//  Created by Артем Устинов on 19.03.2020.
//  Copyright © 2020 Артем Устинов. All rights reserved.
//

import UIKit

class ChatacterTableViewCell: UITableViewCell {
  @IBOutlet var label: UILabel!
  @IBOutlet var avatarImageView: UIImageView!

  private var avatarLoadTask: URLSessionTask?

   override func prepareForReuse() {
       super.prepareForReuse()
       avatarImageView.image = nil
       avatarLoadTask?.cancel()
   }

   // хорошая практика сделать метод настройки ячейки, а аутлтеты сделать приватными
   // легче контролировать, весь код в одном месте
   func setup(with character: Character) {
       label.text = character.name

    guard let imageUrl = URL(string: character.image) else { return }
       avatarLoadTask = URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
           guard let data = data, let image = UIImage(data: data) else { return }
           DispatchQueue.main.async {
               self.avatarImageView.image = image
           }
       }
       avatarLoadTask?.resume()
   }
}
