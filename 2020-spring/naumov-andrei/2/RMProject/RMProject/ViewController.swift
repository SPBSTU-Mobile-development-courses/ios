import UIKit

class ViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    private let characterFacade: CharacterFacade = CharacterFacadeImpl(characterService: CharacterServiceImpl(), characterRepository: CharacterRepositoryImpl())
    private let activity = UIActivityIndicatorView()
    private var characters = [Character]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        characterFacade.getCharacters {
            guard let characters = $0 else { return }
            self.characters = characters
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        activity.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView = activity
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }

    @objc func handleRefreshControl() {
        characterFacade.clear()
        characterFacade.getCharacters {
            self.tableView.refreshControl?.endRefreshing()
            guard let characters = $0 else { return }
            self.characters = characters
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath)
        guard let characterCell = cell as? CharacterTableViewCell
            else {
            fatalError("Table view is not configured")
        }
        let character = characters[indexPath.row]
        characterCell.setup(with: character)
        return characterCell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == characters.count - 1 else { return }
        activity.startAnimating()
        characterFacade.loadMore()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharacterDetailViewController")
            as? CharacterDetailViewController else { return }
        navigationController?.present(viewController, animated: true)
        viewController.setup(with: characters[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
