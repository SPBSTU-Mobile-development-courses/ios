//
//  ViewController.swift
//  TodoList
//
//  Created by Anton Nazarov on 17/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import RealmSwift
import UIKit

final class ViewController: UIViewController {
    private let todoService = TodoService()
    private lazy var todos = todoService.getAll()
    private let identifier = "identifier"
    @IBOutlet private var tableView: UITableView!
    var observer: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        tableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        tableView.tableFooterView = UIView() // эта строчка прячит пустые сепараторы
        observer = todos.observe { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

    deinit {
        observer?.invalidate()
    }
}

// MARK: - Private
private extension ViewController {
    @objc func addTodo() {
        let alert = UIAlertController(title: "Add todo", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addTextField {
            $0.placeholder = "Type your todo"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            let todoText = alert.textFields?.first?.text ?? ""
            self.todoService.add(todoText: todoText)
        }
        alert.addAction(addAction)
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TodoTableViewCell else {
            fatalError("TableView setup is not correct")
        }
        let todo = todos[indexPath.row]
        cell.todo = todo
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        todoService.delete(todo: todos[indexPath.row])
    }
}
