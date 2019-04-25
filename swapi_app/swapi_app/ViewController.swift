//
//  ViewController.swift
//  swapi_app
//
//  Created by Andrew on 21/04/2019.
//  Copyright © 2019 SPbSTU. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    //Проблема 1 - стучится в сеть по одной и той же ссылке, хотя я ее меняю явно в замыкании
    //Проблема 2 - не могу сделать подгрузку данных в таблице по скроллу
    @IBOutlet weak var tableView: UITableView!
    
    var persons =  [Person]()
    var service = NetworkService()
    let cellID = "cell"
    let segueID = "detailSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPersons()
    }
    
    func getPersons() {
        service.getPage() { currentPage in
            self.persons.append(contentsOf: currentPage)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    
//    Проблема 3 - не работает deselection по нажатой ячейке
//    Проблема 4 - как прикрутить данный алерт к failure case'у в замыкании, он на меня орет, когда явно вызываю
    func showAlert() -> Void {
        let alert = UIAlertController(title: "Ooops!", message: "Something went wrong!\nCached data extracting...", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - UITableView methods
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
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detail = segue.destination as? DetailViewController else { return }
        guard let cell = sender as? UITableViewCell else { return }
        let row = tableView.indexPath(for: cell)?.row
        if let indexPath = row {
            detail.person = persons[indexPath]
        }
    }
    
//  Проблема 5 - segue не работает вообще под любым соусом!
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
//        performSegue(withIdentifier: segueID, sender: indexPath)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }

//    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == persons.count-1 && service.requestUrl != nil {
//            getPersons()
//        }
//    }
}
