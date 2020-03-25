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
    
    var image: UIImage?
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
        self.descriptionImage.image = image
        
        guard let tags = post.tags, tags.count != 0 else {
            descriptionTags.text = "no tags"
            return
        }
        
        if tags.count > 1 {
            for index in 0...(tags.count - 2) {
                descriptionTags.text? += tags[index].name + ", "
            }
        }
        descriptionTags.text? += tags[tags.count - 1].name
    }
}
