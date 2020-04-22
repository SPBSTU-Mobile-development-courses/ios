import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
                      UISearchResultsUpdating, UISearchBarDelegate {

    private let newsHeaderPresenter = NewsHeaderPresenter()

    @IBOutlet private var tableView: UITableView!

    private let refreshControl = UIRefreshControl()
    private var searchController = UISearchController()

    private var newsHeaders = [NewsHeader]() {
        didSet {
            let diff = newsHeaderPresenter.getDiff(old: oldValue, new: newsHeaders)
            if !diff.deletions.isEmpty {
                tableView.deleteRows(at: diff.deletions, with: .fade)
            }
            if !diff.insertions.isEmpty {
                tableView.insertRows(at: diff.insertions, with: .automatic)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        newsHeaderPresenter.getNewsHeaders {
            self.newsHeaders = $0
        }

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false

        definesPresentationContext = true

        tableView.register(cellType: NewsHeaderCellView.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = UIRefreshControl()
        tableView.tableFooterView = UIActivityIndicatorView()
        tableView.refreshControl = refreshControl
        tableView.tableHeaderView = searchController.searchBar
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsHeaders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as NewsHeaderCellView
        let newsHeader = newsHeaders[indexPath.row]
        cell.setup(with: newsHeader)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == newsHeaders.count - 3 && searchController.searchBar.text?.isEmpty ?? false else {
            return
        }
        newsHeaderPresenter.loadMore()
    }

    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHeader = newsHeaders[indexPath.row]
        let viewController = NewsDetailsViewController.instantiate() as NewsDetailsViewController
        tableView.deselectRow(at: indexPath, animated: false)
        if selectedHeader.content == nil {
            navigationController?.pushViewController(viewController, animated: true)
            newsHeaderPresenter.loadContent(selectedHeader) {
                viewController.newsHeader = selectedHeader
                viewController.showDetails()
            }
        } else {
            viewController.newsHeader = selectedHeader
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    @objc private func refreshData() {
        newsHeaderPresenter.getNewsHeaders {
            self.newsHeaders = $0
            self.tableView.reloadData()
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        newsHeaders = newsHeaderPresenter.filter(infix: searchController.searchBar.text ?? "")
    }

}
