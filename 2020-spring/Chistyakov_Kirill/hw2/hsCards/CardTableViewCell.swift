//
//  CardTableViewCell.swift
//  hsCards
//
//  Created by Kirill Chistyakov on 17.03.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import UIKit

final class CardTableViewCell: UITableViewCell {
    @IBOutlet private var numberLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var cardImageView: UIImageView!
    private var imageLoadTask: URLSessionTask?
    override func prepareForReuse() {
        super.prepareForReuse()
        cardImageView.image = nil
        imageLoadTask?.cancel()
    }
    func setup(card: Card, number: Int) {
        nameLabel.text = card.name
        numberLabel.text = String(number)
        cardImageView.image = UIImage(named: "minion-loading.png")!
        guard let imageUrl = card.imageUrl else { return }
        imageLoadTask = URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.cardImageView.image = image
            }
        }
        imageLoadTask?.resume()
    }
    func getImage() -> UIImage? {
        return cardImageView.image
    }
}
