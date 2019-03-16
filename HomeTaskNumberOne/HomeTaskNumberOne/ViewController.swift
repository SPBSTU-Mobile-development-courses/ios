//
//  ViewController.swift
//  HomeTaskNumberOne
//
//  Created by Максим Егоров on 10/03/2019.
//  Copyright © 2019 Максим Егоров. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet private var searcBar: UISearchBar!
    
    @IBOutlet private var tableView: UITableView!
    
    private var identifier = "cell"

    private let weatherService = WeatherServiceNetwork()
    private var selectCell : Int?
    var weathers : [Weather] = Array()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searcBar.delegate = self
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TableViewCell
        if(!weathers.isEmpty)
        {
            cell?.cityNameLabel.text = weathers[indexPath.row].location.name
            cell?.currentTempCLabel.text = String(weathers[indexPath.row].current.tempC)
            weatherService.getIcon(url: weathers[indexPath.row].current.icon) { (icon) in
                cell?.icon.image = icon
            }
        }
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let intent = segue.destination as? DetailsViewController {
            guard let cell = sender as? UITableViewCell else { return }
            let indexPathRow = tableView.indexPath(for: cell)?.row
            if let indexPath = indexPathRow {
                intent.title = weathers[indexPath].location.name
                intent.url = weathers[indexPath].current.icon
                intent.values.append(String(weathers[indexPath].current.tempC))
                intent.values.append(String(weathers[indexPath].current.tempF))
                intent.values.append(String(weathers[indexPath].current.windMph))
                intent.values.append(String(weathers[indexPath].current.windKph))
                intent.values.append(String(weathers[indexPath].current.windDir))
                intent.values.append(String(weathers[indexPath].current.humidity))
                intent.values.append(String(weathers[indexPath].current.cloud))
                intent.values.append(String(weathers[indexPath].current.tempF))
                intent.values.append(String(weathers[indexPath].current.feelslikeC))
                intent.values.append(String(weathers[indexPath].current.feelslikeF))
                
            }
        }
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        weatherService.getCurrentWeather(location: searchBar.text ?? "") {  weather in
            guard !searchBar.text!.isEmpty
                else{
                    return
            }
            self.weathers.append(weather)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            searchBar.text = ""
        }
    
    
    }

}
