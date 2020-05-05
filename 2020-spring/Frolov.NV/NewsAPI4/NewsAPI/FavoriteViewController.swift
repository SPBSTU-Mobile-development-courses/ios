//
//  FavoriteViewController.swift
//  NewsAPI
//
//  Created by Никита Фролов  on 29.04.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import UIKit

class FavoriteViewController:UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    
    @IBOutlet var tableView: UITableView!
    
    var searchController = UISearchController(searchResultsController: nil)
    let refreshControl = UIRefreshControl()
    var news = [OneNew]()
    var searchingNews = [OneNew]()
    var newsFacade:NewsFacade!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsFacade = NewsFacade(string: "")
        refresh(newsFacade)
    
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Reload News, please wait...")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search News"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        tableView.rowHeight = 307
    }
    
    @objc func refresh(_:AnyObject) {
           newsFacade.getFavoriteNews(completion: {(newsArray) in
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
        let delete = UITableViewRowAction(style: .destructive, title: "delete") {_, indexPath in
            self.newsFacade.deleteFromFavorite(news: self.news[indexPath.row])
            //self.news.remove(at: indexPath.row)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            self.refresh(self.newsFacade)
        }
        return [delete]
    }
}
