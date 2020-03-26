//
//  TableController.swift
//  calculator
//
//  Created by Admin on 22.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation
import UIKit

class TableController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    weak var delegate = UIApplication.shared.delegate

    @IBOutlet private var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.table.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let delegate = delegate as? AppDelegate else {
            return 0
        }
        return delegate.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? TableViewCell else {
            fatalError("probably not really possible")
        }
        guard let delegate = delegate as? AppDelegate else {
            return cell
        }
        cell.setup(text: delegate.data[indexPath.row])
        return cell
    }
}
