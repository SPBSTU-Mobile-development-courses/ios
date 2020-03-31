//
//  ViewController.swift
//  Memes
//
//  Created by panandafog on 20.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let memeFacade: MemeFacade = MemeFacadeImpl(memeService: MemeService(), memeRepository: MemeRepositoryImpl())
    private let activity = UIActivityIndicatorView()
    private let service = MemeService()
    private var posts = [Post]()

    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        memeFacade.getMemes(completion: { newMemes in
            guard let newMemes = newMemes else { return }
            self.posts = newMemes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        tableView.tableFooterView = activity
    }

    @objc func handleRefreshControl() {
        memeFacade.getRepository().clear()
        memeFacade.getMemes(completion: { newMemes in
            guard let newMemes = newMemes else { return }
            self.posts = newMemes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        tableView.refreshControl?.endRefreshing()
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as? MemeCell else {
            fatalError("Table view is not configured")
        }
        let post: Post = posts[indexPath.row]

        cell.setup(with: post)
        if !activity.isAnimating { activity.startAnimating() }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == posts.count - 1 else { return }
        memeFacade.loadMore()
        activity.stopAnimating()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
                return
        }
        viewController.post = posts[indexPath.row]
        navigationController?.present(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
