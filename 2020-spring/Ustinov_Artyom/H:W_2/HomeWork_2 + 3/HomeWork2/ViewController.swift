import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  let charactersService = CharacterService()
  var characters = [Character]()

  override func viewDidLoad() {
    super.viewDidLoad()

    charactersService.getCharacters(completion: { newCharacters in
      guard let newCharacters = newCharacters else { return }
      self.characters = newCharacters
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    })
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = 60
//    tableView.rowHeight = UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    characters.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChatacterTableViewCell", for: indexPath)
    guard let characterCell = cell as? ChatacterTableViewCell else {
      fatalError("Table is ")
    }
    let character = characters[indexPath.row]
    characterCell.setup(with: character)
    return cell
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard indexPath.row == characters.count - 1 else {
      return
    }
    charactersService.getMoreCharacters { newCharacters in
      guard let newCharacters = newCharacters else { return }
      self.characters.append(contentsOf: newCharacters)
      DispatchQueue.main.async {
        self.tableView.reloadData()

      }
    }

  }

}
