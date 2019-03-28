//
//  ViewController.swift
//  HomeTaskNumberOne
//
//  Created by Максим Егоров on 10/03/2019.
//  Copyright © 2019 Максим Егоров. All rights reserved.
//

import RealmSwift
import UIKit

class ViewController: UIViewController {
    @IBOutlet private var searcBar: UISearchBar!
    @IBOutlet private var tableView: UITableView!

    private var identifier = "cellind"
    private let weatherService = WeatherServiceNetwork()
    private let weatherDBService = WeatherDBService()
    private lazy var weathers = weatherDBService.getAll()

    override func viewDidLoad() {
        super.viewDidLoad()
        searcBar.delegate = self
        tableView.rowHeight = 100
        tableView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let intent = segue.destination as? DetailsViewController else {
            return
        }
        guard let cell = sender as? UITableViewCell else { return }
        let indexPathRow = tableView.indexPath(for: cell)?.row
        guard let indexPath = indexPathRow else {
            return
        }
        let weather = weathers[indexPath]
        intent.title = weather.cityName
        intent.url = weather.imagePath
        intent.values.append(String(weather.temperatureCelcius))
        intent.values.append(String(weather.temperatureFarenheit))
        intent.values.append(String(weather.windMph))
        intent.values.append(String(weather.windKph))
        intent.values.append(String(weather.windDirection))
        intent.values.append(String(weather.humidity))
        intent.values.append(String(weather.cloud))
        intent.values.append(String(weather.feelsLikeFarenheit))
        intent.values.append(String(weather.feelsLikeCelcius))
        intent.values.append(weather.cityName)
    }

    @IBAction private func deletaAll(_ sender: UIBarButtonItem) {
        guard !weathers.isEmpty else {
            return
        }
        let alert = UIAlertController(title: nil, message: "Do you want to delete all cells?", preferredStyle: .alert)

        let deleteAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            self?.weatherDBService.deleteAll()
            self?.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "No", style: .destructive)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    @IBAction private func refresh(_ sender: UIBarButtonItem) {
        reloadWeather()
    }

    func reloadWeather() {
        for weather in weathers {
            weatherService.getCurrentWeather(location: weather.cityName) { [weak self] newWeather in
                self?.weatherDBService.update(weather: weather, newWeather: newWeather)
            }
        }
        tableView.reloadData()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        weathers = weatherDBService.getAll()
        searchBar.resignFirstResponder()
        guard weatherDBService.isExistingItem(cityName: searchBar.text ?? "") else {
            return
        }
        weatherService.getCurrentWeather(location: searchBar.text ?? "") { [weak self] weather in
            self?.weatherDBService.add(weather: weather)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            searchBar.text = ""
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let itemFound = weatherDBService.select(cityName: searchText) else {
            return
        }
        weathers = itemFound
        tableView.reloadData()
        if searchText.isEmpty {
            weathers = weatherDBService.getAll()
            tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TableViewCell else {
            fatalError("TableView setup is not correct")
        }
        let todo = weathers[indexPath.row]
        cell.setCell(cityName: todo.cityName, tempC: String(todo.temperatureCelcius)+"º", imagePath: todo.imagePath)
//        cell.cityNameLabel.text = todo.cityName
//        cell.currentTempCLabel.text = String(todo.temperatureCelcius)+"º"
//        weatherService.getIcon(identifier: todo.cityName, url: todo.imagePath) { icon in
//            cell.icon.image = icon
//        }
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        weatherDBService.delete(city: weathers[indexPath.row])
        tableView.reloadData()
    }
}
