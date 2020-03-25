//
//  ViewController.swift
//  NewsAPIProgramm
//
//  Created by Никита Фролов  on 24.03.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var news = [OneNew]()
    let newsService = NewsService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsService.getNews(complition: {(news) in
            guard let news = news else {return}
            self.news = news
            DispatchQueue.main.async {
                self.tableView.reloadData();
            }
        })
        tableView.dataSource = self
        tableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oneNews", for: indexPath)
        guard let newsCell = cell as? ViewCellNews else {
            fatalError("Table view is not configured")
        }
        let oneNews = news[indexPath.row]
        newsCell.insert(with: oneNews)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == news.count - 1 else {
            return
        }
        newsService.getMoreNews(complition:{ (newCharacters) in
            guard let newCharacters = newCharacters else {return}
            self.news.append(contentsOf: newCharacters)
            DispatchQueue.main.async{ self.tableView.reloadData() }
        })
    }
    
}

