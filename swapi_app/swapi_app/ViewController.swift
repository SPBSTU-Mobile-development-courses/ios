//
//  ViewController.swift
//  swapi_app
//
//  Created by Andrew on 29/03/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController/*, UITableViewDataSource*/ {
    
    var Persons: [Char] = []
    //let ident = "ident"
    
    func createAlert() -> Void {
        let alert = UIAlertController(title: "Ooops!", message: "Something went wrong!\nTry again later...", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
            exit(1)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ident, for: indexPath)
        cell.textLabel?.text = Persons[indexPath.row].name
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Persons.count
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("https://swapi.co/api/people").responseJSON { response in
            
            guard let statusCode = response.response?.statusCode else {
                self.createAlert()
                return
            }
            print(statusCode)
            print(response)
//            if let result = try? JSONDecoder().decode([Char].self, from: response.data!) {
//                self.Persons = result
//                print("Success!")
//            } else {
//                print("Fail!")
//                self.createAlert()
//            }
            
        }
    }
}

