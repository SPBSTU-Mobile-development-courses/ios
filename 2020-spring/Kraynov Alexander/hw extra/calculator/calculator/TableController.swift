//
//  TableController.swift
//  calculator
//
//  Created by Admin on 22.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation


import UIKit

class TableController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    let delegate = 	UIApplication.shared.delegate as! AppDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? TableViewCell else {
            fatalError("probably not really possible")
        }
        cell.setup(text: delegate.data[indexPath.row])
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.table.reloadData()
    }
    
    @IBOutlet weak var table: UITableView!
}
