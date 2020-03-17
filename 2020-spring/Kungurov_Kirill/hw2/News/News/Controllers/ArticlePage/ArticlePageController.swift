//
//  ArticlePageController.swift
//  News
//
//  Created by Kirill Kungurov on 14.03.2020.
//  Copyright © 2020 Kirill Kungurov. All rights reserved.
//

import Kingfisher
import UIKit

final class ArticlePageController: UIViewController {
    var article: Article?

    @IBOutlet private var articleImage: UIImageView!
    @IBOutlet private var articleAuthor: UILabel!
    @IBOutlet private var aritcleDate: UILabel!
    @IBOutlet private var articleContent: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let article = self.article else { return }
        aritcleDate.text = article.date
        articleAuthor.text = article.author
        articleContent.text = article.description
        articleImage.kf.setImage(with: article.imageUrl)
        self.title = article.title
    }

    @IBAction private func buttonTapped(_ sender: UIButton) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "OriginalArticleController") as? OriginalArticleController else { return }
        viewController.baseUrl = article?.articleUrl
        viewController.articleTitle = article?.title
        navigationController?.pushViewController(viewController, animated: true)
    }
}
