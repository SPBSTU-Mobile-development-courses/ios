//
//  ArticleListController.swift
//  News
//
//  Created by Kirill Kungurov on 14.03.2020.
//  Copyright © 2020 Kirill Kungurov. All rights reserved.
//

import Foundation
import UIKit

final class ArticleListController: UIViewController {
    private var articleService: ArticleService = ArticleServiceImpl()
    private let cellIdentifier = "ArticleTableViewCell"
    private var articles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        articleService.getArticles {
            guard let articles = $0 else { return }
            self.articles = articles
        }
        tableView.dataSource = self
        self.title = articleService.tag
    }
}

extension ArticleListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArticleTableViewCell else {
            fatalError("TableView wasn't configured")
        }
        let article = articles[indexPath.row]
        cell.setUp(with: article)
        return cell
    }
}

extension ArticleListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == articles.count - 1 else { return }
        articleService.getArticles {
            guard let newArticles = $0 else { return }
            self.articles.append(contentsOf: newArticles)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "ArticlePageController") as? ArticlePageController else {
                return
        }
        viewController.article = articles[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
