//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Anton Nazarov on 06.03.2020.
//  Copyright © 2020 Anton Nazarov. All rights reserved.
//

import UIKit

final class CharacterViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    private var characters = [Character]() {
        // didSet/willSet вызывается при каждом присваивании свойства. Массив value type, присваивается заново даже при изменении
        didSet {
            DispatchQueue.main.async { // можно общаться с UI только на главном потоке, прочитать про GCD самим
                self.tableView.reloadData()
            }
        }
    }
    private let characterService: CharacterService = CharacterServiceImpl()
    private let cellIdentifier = "CharacterTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        characterService.getCharacters {
            guard let characters = $0 else { return }
            self.characters = characters
        }
        tableView.rowHeight = 120
    }
}

// MARK: - UITableViewDelegate
// определения протоколов принято выносить в extension. Это удобно визуально разделяет код на группы методов
extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == characters.count - 1 else { return }
        characterService.getMoreCharacters {
            guard let characters = $0 else { return }
            self.characters.append(contentsOf: characters)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // этого не было на лекции. Метод вызывается при клике на ячейку. Мы хотим открыть детальную информацию о ней
        guard let viewController = UIStoryboard(name: "Main", bundle: nil) // открываем главный сториборд и достаем оттуда viewController по идентфикатору. Как с ячейкой
            .instantiateViewController(withIdentifier: "CharacterDetailViewController") as? CharacterDetailViewController else {
                return
        }
        viewController.character = characters[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true) // в сториборде добавился navigationController
        tableView.deselectRow(at: indexPath, animated: true) // снимаем выделение ячейки
    }
}

// MARK: - UITableViewDataSource
extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CharacterTableViewCell else {
            fatalError("TableView wasn't configured") // или можно например вернуть здесь пустую ячейку просто return UITableViewCell()
        }
        let character = characters[indexPath.row]
        cell.setup(with: character)
        return cell
    }
}
