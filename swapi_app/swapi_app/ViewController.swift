//
//  ViewController.swift
//  swapi_app
//
//  Created by Andrew on 21/04/2019.
//  Copyright © 2019 SPbSTU. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    //TODO: solve data corrupted shit. controller dont update data after scrolling the table. tableView "forRowAt" function dont be called
    @IBOutlet weak var tableView: UITableView!
    var persons =  [Person]()
    var service = NetworkService()
    let cellID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPersons()
    }
    
    func getPersons() {
        service.getPage() { page in
            self.persons.append(contentsOf: page)
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //TODO: desection effect to selected tableView.row
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        guard let cell = sender as? UITableViewCell else { return }
        let indexPathRow = tableView.indexPath(for: cell)?.row
        if let indexPath = indexPathRow {
            detailViewController.person = persons[indexPath]
        }
    }
    
    
//    TODO: how to link this shit with NetworkService .failure case?
//    func showAlert() -> Void {
//        let alert = UIAlertController(title: "Ooops!", message: "Something went wrong!\nCached data extracting...", preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
//            alert.dismiss(animated: true, completion: nil)
//        }))
//        self.present(alert, animated: true, completion: nil)
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(indexPath.row == persons.count - 1) && (service.requestUrl != nil) {
            self.getPersons()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = persons[indexPath.row].name
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
