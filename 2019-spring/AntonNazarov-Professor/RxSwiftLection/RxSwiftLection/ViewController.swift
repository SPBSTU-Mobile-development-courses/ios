//
//  ViewController.swift
//  RxSwiftLection
//
//  Created by Anton Nazarov on 26/04/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import RxSwift
import Alamofire
import RxCocoa

class ViewController: UIViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet private var tableView: UITableView!
    private let repo: CityRepository = CityRepositoryImpl()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.dimsBackgroundDuringPresentation = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        let cities = repo.getCities().asObservable()
        let search = searchController.searchBar.rx.text.orEmpty.asObservable()

        Observable.combineLatest(cities, search) { citiesArray, searchString in
            guard !searchString.isEmpty else { return citiesArray }
            return citiesArray.filter { $0.lowercased().contains(searchString.lowercased()) }
            }
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "identifier")) { tableview, city, cell in
                cell.textLabel?.text = city
            }
            .disposed(by: disposeBag)
    }
}

