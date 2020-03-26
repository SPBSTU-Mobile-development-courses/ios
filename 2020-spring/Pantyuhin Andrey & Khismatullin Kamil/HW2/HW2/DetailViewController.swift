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
        guard let url = post.images?[0].url else { return }
        _ = URLSession.shared.dataTask(with: url) { data, _, _  in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.descriptionImage.image = image
            }
        }.resume()
        guard let tags = post.tags, tags.count != 0 else {
            descriptionTags.text = "no tags"
            return
        }
        var tagsNames = [String]()
        tags.forEach{tag in tagsNames.append(tag.name)}
        descriptionTags.text! += tagsNames.joined(separator: ", ")
    }
}
