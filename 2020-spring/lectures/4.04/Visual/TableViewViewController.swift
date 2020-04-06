//
//  TableViewViewController.swift
//  Visual
//
//  Created by Anton Nazarov on 20/04/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    var items = [Int]()
    let identifier = "identifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: tableView, action: #selector(tableView.reloadData)
        )
    }

    @objc func addNewElements() {
        var newItems = items
        for _ in 0...2 {
            newItems.append(newItems.count)
        }
        let newIndexPaths = stride(from: items.count, to: newItems.count, by: 1)
            .map { IndexPath(row: $0, section: 0) }
        items = newItems
        tableView.insertRows(at: newIndexPaths, with: .fade)
    }
}

// MARK: - UITableViewDataSource
extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = "\(items[indexPath.row])"
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            self.items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
        }
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { _, indexPath in
            self.items[indexPath.row] = Int.random(in: 1...10)
            self.tableView.reloadRows(at: [indexPath], with: .middle)
        }
        return [delete, edit]
    }
}
