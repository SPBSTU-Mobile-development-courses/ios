//
//  DetailViewController.swift
//  HW2
//
//  Created by panandafog on 23.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet var descriptionImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var descriptionTags: UILabel!
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let post = self.post else
        {
            descriptionLabel.text = "no post"
            return
        }
        descriptionLabel.text = post.title
        descriptionTags.text = "tags: "
        if (post.tags == nil)
        {
            descriptionTags.text = "no tags"
        } else {
            var index: Int
            for index in 0...(post.tags!.count - 2) {
                if post.tags![index].name != nil {
                    descriptionTags.text! += post.tags![index].name! + ", "
                }
            }
            if post.tags![post.tags!.count - 1].name != nil {
                descriptionTags.text! += post.tags![post.tags!.count - 1].name!
            }
        }
        guard let url = post.images?[0].url else { return }
        _ = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.descriptionImage.image = image
            }
        }.resume()
    }
}
