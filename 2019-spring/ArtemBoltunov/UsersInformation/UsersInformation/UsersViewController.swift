//
//  UsersViewController.swift
//  UsersInformation
//
//  Created by Artem on 24/03/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDataSource {
    @IBOutlet private var tableView: UITableView!
    private let identifier = "userCell"
    private var users = [User]()
    private let userService = UserServiceNetwork()
    private let allUsersRealm = AllUsersRealm()

    private func getNewInformation() {
        userService.getUsers(url: "http://bolart.ru:3012/people") { users in
            self.users = users
            DispatchQueue.main.async {
                self.allUsersRealm.updateAllUsers(users: users)
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.getNewInformation()
        return
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        guard let cell = sender as? UITableViewCell else { return }
        let indexPathRow = tableView.indexPath(for: cell)?.row
        if let indexPath = indexPathRow {
            detailViewController.user = users[indexPath]
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}
