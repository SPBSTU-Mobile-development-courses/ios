//
//  ViewController.swift
//  Pictures
//
//  Created by Vladimir GL on 03.04.2020.
//  Copyright © 2020 VDTA. All rights reserved.
//

import UIKit

final class PictureDetailViewController: UIViewController {
  @IBOutlet private var likes: UILabel!
  @IBOutlet private var favorites: UILabel!
  @IBOutlet private var comments: UILabel!
  @IBOutlet private var tags: UILabel!
  @IBOutlet private var userName: UILabel!
  @IBOutlet private var userImage: UIImageView!
  @IBOutlet private var webImage: UIImageView!
  var picture: Image?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let picture = self.picture else
    {
      fatalError()
    }
    
    likes.text = "Likes: " + String(picture.likes)
    tags.text = "Tags: " + picture.tags
    favorites.text = "Favs: " + String(picture.favorites)
    comments.text = "Coms: " + String(picture.comments)
    userName.text = "Author: " + picture.user
    
    guard let url = picture.url else { return }
    _ = URLSession.shared.dataTask(with: url) { data, _, _  in
      guard let data = data, let image = UIImage(data: data) else { return }
      DispatchQueue.main.async {
        self.webImage.image = image
      }
    }.resume()
    
    guard let urlUser = picture.urlUser else { return }
    _ = URLSession.shared.dataTask(with: urlUser) { data, _, _  in
      guard let data = data, let image = UIImage(data: data) else { return }
      DispatchQueue.main.async {
        self.userImage.image = image
      }
    }.resume()
  }
}
