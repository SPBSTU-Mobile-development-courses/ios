//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Anton Nazarov on 09/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    let currencyService: CurrencyService = CurrencyServiceNetwork()//CurrencyServiceLocal()
    let identifier = "CurrencyTableViewCell"
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var textField: UITextField!
    var currentValue = 1.0 {
        didSet {
            tableView.reloadData()
        }
    }

    @IBAction private func editCurrentValue(_ sender: UITextField) {
        guard let newValue = Double(sender.text ?? "") else {
            return
        }
        currentValue = newValue
    }

    var currencies = [Currency]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        currencyService.getCurrencies { currencies in
            self.currencies = currencies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = currencies[indexPath.row].name
        let convertedValue = "\(currentValue * currencies[indexPath.row].rate)"
        cell.detailTextLabel?.text = String(convertedValue.prefix(5))
        return cell
    }
}
