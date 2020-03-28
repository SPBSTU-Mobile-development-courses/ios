//
//  DetailViewController.swift
//  HW2
//
//  Created by panandafog on 23.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    var post: Post?

    @IBOutlet private var descriptionImage: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var descriptionTags: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let post = self.post else {
            descriptionLabel.text = "no post"
            return
        }
        descriptionLabel.text = post.title
        descriptionTags.text = "tags: "
        guard var textField = descriptionTags.text else {
            return
        }
        guard let url = post.images?[0].url else { return }
        descriptionImage.kf.setImage(with: url)
        guard let tags = post.tags, tags.isEmpty else {
            descriptionTags.text = "no tags"
            return
        }
        var tagsNames = [String]()
        tags.forEach { tag in tagsNames.append(tag.name) }
        textField += tagsNames.joined(separator: ", ")
    }
}
