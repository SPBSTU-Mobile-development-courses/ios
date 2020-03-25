//
//  ViewCellNews.swift
//  NewsAPIProgramm
//
//  Created by Никита Фролов  on 25.03.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import UIKit

class ViewCellNews: UITableViewCell {
    @IBOutlet var titleLable:UILabel!
    @IBOutlet var imageViewCell:UIImageView!
    private var imageNewsLoadTask:URLSessionTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageNewsLoadTask?.cancel()
    }
    
    func insert(with new: OneNew) {
        titleLable.text = new.title
        guard let imageUrl = URL(string: new.image) else {return}
        imageNewsLoadTask = URLSession.shared.dataTask(with: imageUrl) {data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self.imageViewCell.image = image
            }
        }
        imageNewsLoadTask?.resume()
    }
}

