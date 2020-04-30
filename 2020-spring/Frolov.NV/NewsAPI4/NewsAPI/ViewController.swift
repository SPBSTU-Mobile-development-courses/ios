//
//  ViewController.swift
//  NewsAPI
//
//  Created by Никита Фролов  on 25.03.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,
UISearchResultsUpdating{
    @IBOutlet var tableView: UITableView!
    
    var searchController = UISearchController(searchResultsController: nil)
    var news = [OneNew]()
    var searchingNews = [OneNew]()
    let refreshControl = UIRefreshControl()
    var country:String!
    var newsFacade:NewsFacade!

    override func viewDidLoad() {
        super.viewDidLoad()
        newsFacade = NewsFacade(string: country)
        refresh(newsFacade)
//        newsFacade.getNews{(newsArray) in
//            guard let newsArray = newsArray else {return}
//            self.news = newsArray
//            DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//        }
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Reload News, please wait...")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
       
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
        if (isFiltering) {
            return searchingNews.count
        }
        return news.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OneNews", for: indexPath)
        guard let newsCell = cell as? NewsTableViewCell else {
            fatalError("Table view is not configured")
        }
        if (isFiltering) {
            let oneNew = searchingNews[indexPath.row]
            newsCell.insert(with: oneNew)
            return newsCell
        }
        let oneNews = news[indexPath.row]
        newsCell.insert(with: oneNews)
        return newsCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == news.count - 1 else {
            return
        }
        newsFacade.loadMore()
    }
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
       return searchController.isActive && !isSearchBarEmpty
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        searchingNews = news.filter({$0.title!.prefix(searchBar.text!.count) == Substring(searchBar.text ?? "")})
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Favorite") {_, indexPath in
            self.newsFacade.getToFavoriteList(news: self.news[indexPath.row])
        }
        return [edit]
    }
    
}

