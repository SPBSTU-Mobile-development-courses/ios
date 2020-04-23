import UIKit

final class CharacterViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    private var characters = [Character]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private let characterFacade: CharacterFacade = CharacterFacadeImpl(characterService: CharacterServiceImpl(), characterRepository: CharacterRepositoryImpl())
    private let cellIdentifier = "CharacterTableViewCell"
    private let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        characterFacade.getCharacters {
            guard let characters = $0 else { return }
            self.characters = characters
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc private func pullToRefresh() {
        characterFacade.getCharacters {
            guard let characters = $0 else { return }
            self.characters = characters
            DispatchQueue.main.async {
                self.refresh.endRefreshing()
            }
        }
    }
}

//MARK: UITableViewDelegate
extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == characters.count - 1 else { return }
        let loadNext = UIActivityIndicatorView(style: .gray)
        loadNext.startAnimating()
        loadNext.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50)
        self.tableView.tableFooterView = loadNext
        loadNext.hidesWhenStopped = true
        characterFacade.loadMore { _ in
            DispatchQueue.main.async {
                loadNext.stopAnimating()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
                return
        }
        viewController.character = characters[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true) 
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: UITableViewDataSource
extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CharacterTableViewCell else {
            print("TableView wasn't configured")
            return UITableViewCell()
        }
        let character = characters[indexPath.row]
        cell.setup(with: character)
        return cell
    }
}
