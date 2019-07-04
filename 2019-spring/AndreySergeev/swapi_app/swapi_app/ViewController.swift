//
//  ViewController.swift
//  swapi_app
//
//  Created by Andrew on 27/04/2019.
//  Copyright © 2019 SPbSTU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var people = [Person]()
    private var storageService = StorageService()
    private var service = NetworkService()
    private let cellID = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPeople()
    }
    
    
    //MARK: - completionHandler for NetworkService
    func getPeople() {
        self.service.getPage { result, hasNetworkConnection in
            if hasNetworkConnection {
                self.people.append(contentsOf: result)
                self.storageService.clear()
                self.storageService.store(data: self.people)
            } else {
                self.createAlert()
                self.people = self.storageService.getData()
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Alertion
    func createAlert() -> Void {
        let alert = UIAlertController(title: "Oooops!", message: "Some problems with internet connection!\n Cached data extracting...", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? DetailViewController
        let index = tableView.indexPathForSelectedRow?.row
        destination?.person = people[index!]
    }
    
}

//MARK: - tableView methods
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CustomTableViewCell
        let person = self.people[indexPath.row]
        switch person.gender {
        case "male":
            cell.setAvatar(img: "avatar-male")
        case "female":
            cell.setAvatar(img: "female-avatar")
        default:
            cell.setAvatar(img: "generic-avatar")
        }
        cell.setNameLabel(name: person.name)
        cell.setGenderLabel(gender: person.gender)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row == people.count - 1 && self.service.requestUrl != nil) {
            self.getPeople()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
