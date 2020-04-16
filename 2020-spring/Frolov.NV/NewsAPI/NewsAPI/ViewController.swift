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
    let newsService = NewsService()
    var news = [OneNew]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        newsService.getNews(completion: {(newsArray) in
            guard let newsArray = newsArray else {return}
            self.news = newsArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 307
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
        newsService.getMoreNews(complition:{ (newCharacters) in
            guard let newCharacters = newCharacters else {return}
            self.news.append(contentsOf: newCharacters)
            DispatchQueue.main.async{ self.tableView.reloadData() }
        })
    }
    
}

