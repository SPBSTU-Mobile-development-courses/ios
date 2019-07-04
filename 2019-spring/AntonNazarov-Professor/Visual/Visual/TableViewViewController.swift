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
    var items = [Int]() {
        didSet {
            let newIndexPaths = stride(from: oldValue.count, to: items.count, by: 1)
                .map { IndexPath(row: $0, section: 0) }
            tableView.insertRows(at: newIndexPaths, with: UITableView.RowAnimation.left)
        }
    }
    let identifier = "identifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add
            , target: self, action: #selector(addNewElements))
    }

    @objc func addNewElements() {
        var oldItems = items
        for _ in 0...2 {
            oldItems.append(oldItems.count)
        }
        items = oldItems
    }
}

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
