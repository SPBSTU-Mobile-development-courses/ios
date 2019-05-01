//
//  ViewController.swift
//  Notes
//
//  Created by Mordvintseva Alena on 10/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import RealmSwift
import Reusable
import UIKit

class NotesListViewController: UIViewController, UITableViewDelegate {
    @IBOutlet private var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    private var notes = [Note]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: NotesListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(goToAddNoteController))
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)

        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.placeholder = "Search note"
        self.searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(cellType: NotesListCell.self)
        self.tableView.register(cellType: NotesListCellWithImage.self)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 400
        self.tableView.tableFooterView = UIView()

        viewModel.onNotesChanged = { [unowned self] in
            self.notes = $0
        }
        viewModel.load()
    }

    @objc func goToAddNoteController() {
        let storyboard = UIStoryboard(name: .addNoteStoryboard, bundle: nil)
        guard let addNoteViewController = storyboard.instantiateViewController(withIdentifier: .addNoteViewControllerID) as? AddNoteViewController else {
            fatalError("Can't instantiate addNoteViewController")
        }
        self.navigationController?.pushViewController(addNoteViewController, animated: true)
    }

    @objc func onDidReceiveData(_ notification: Notification) {
        print("Data did receive")
        if let data = notification.userInfo as? [String: String] {
            viewModel.add(data)
        }
    }
}

extension NotesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notes.isEmpty == true {
            if let emptyView = Bundle.main.loadNibNamed("EmptyView", owner: self, options: nil)?.first as? EmptyView {
                emptyView.setMessage(title: "No notes found", message: "Add a note or change search parameters")
                self.tableView.backgroundView = emptyView
            }
        } else {
            tableView.restore()
        }
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CellProtocol
        if notes[indexPath.row].imagePath.isEmpty == true {
            cell = tableView.dequeueReusableCell(for: indexPath) as NotesListCell
        } else {
            cell = tableView.dequeueReusableCell(for: indexPath) as NotesListCellWithImage
        }

        cell.setInfo(note: notes[indexPath.row])
        // swiftlint:disable:next force_cast
        return cell as! UITableViewCell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        viewModel.delete(notes[indexPath.row])
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

extension NotesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText)
    }
}
