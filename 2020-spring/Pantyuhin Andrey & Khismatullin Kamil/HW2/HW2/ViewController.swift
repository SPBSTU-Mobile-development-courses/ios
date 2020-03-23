//
//  ViewController.swift
//  HW2
//
//  Created by panandafog on 20.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    let memeService = MemeService()
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeService.getMemes(completion: {
            (newMemes) in
            guard let newMemes = newMemes else { return }
            self.posts = newMemes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.rowHeight = 325
        tableView.estimatedRowHeight = 325
        tableView.rowHeight = UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as? MemeCell else {
            fatalError("Table view is not configured")
        }
        let post: Post = posts[indexPath.row]


        print(post.images![0].type)
        
        cell.setup(with: post)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == posts.count - 1 else { return }
        memeService.getMemes {
            guard let posts = $0 else {
                print("post is nil")
                return }
            self.posts.append(contentsOf: posts)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // этого не было на лекции. Метод вызывается при клике на ячейку. Мы хотим открыть детальную информацию о ней
        guard let viewController = UIStoryboard(name: "Main", bundle: nil) // открываем главный сториборд и достаем оттуда viewController по идентфикатору. Как с ячейкой
            .instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
                return
        }
        viewController.post = posts[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true) // в сториборде добавился navigationController
        tableView.deselectRow(at: indexPath, animated: true) // снимаем выделение ячейки
    }
    
}

