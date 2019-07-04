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

class NotesListViewController: UIViewController, UITableViewDelegate, StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
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
        let addNoteViewController = AddNoteViewController.instantiate()
        addNoteViewController.onAddNote = { note in
            self.viewModel.add(note)
        }
        self.navigationController?.pushViewController(addNoteViewController, animated: true)
    }
}

extension NotesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notes.isEmpty == true {
            let emptyView = EmptyView.loadFromNib()
            emptyView.setMessage(title: "No notes found", message: "Add a note or change search parameters")
            self.tableView.backgroundView = emptyView
        } else {
            tableView.restore()
        }
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CellProtocol
        if notes[indexPath.row].imagePath.isEmpty {
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
