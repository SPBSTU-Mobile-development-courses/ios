//
//  NewsCellController.swift
//  NewsAPI
//
//  Created by Никита Фролов  on 25.03.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var imageNewsView:UIImageView!
    private var loadTask: URLSessionTask?

    override func prepareForReuse() {
        super.prepareForReuse()
        loadTask?.cancel()
        //imageNewsView = nil
    }
    
    func insert(with new: OneNew) {
        titleLabel.text = new.title
        guard let imageUrl = URL(string: new.urlToImage ?? "") else {return}
        loadTask = URLSession.shared.dataTask(with: imageUrl) {data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self.imageNewsView.image = image
            }
        }
        loadTask?.resume()
    }
}

