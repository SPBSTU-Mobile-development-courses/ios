//
//  ViewController.swift
//  NewsAPI
//
//  Created by Никита Фролов  on 25.03.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   @IBOutlet var tableView: UITableView!
    //let newsService = NewsService()
    let newsFacade = NewsFacade()
    var news = [OneNew]()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsFacade.getNews(completion: {(newsArray) in
            guard let newsArray = newsArray else {return}
            self.news = newsArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Reload News, please wait...")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        tableView.rowHeight = 307
    }
    
    @objc func refresh(_:AnyObject) {
        newsFacade.reload(completion: {(newsArray) in
        guard let newsArray = newsArray else {return}
        self.news = newsArray
        DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        self.refreshControl.endRefreshing()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? ViewControllSelectNew)?.news = news[tableView.indexPathForSelectedRow!.row]
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "OneNews", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OneNews", for: indexPath)
        guard let newsCell = cell as? NewsTableViewCell else {
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
        newsFacade.loadMore()
    }
    
}

