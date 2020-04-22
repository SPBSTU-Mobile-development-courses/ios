import UIKit

import DeepDiff

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
                      UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet private var tableView: UITableView!

    private let newsHeaderFacade = NewsHeaderFacade()
    private let refreshControl = UIRefreshControl()
    private var searchController = UISearchController()

    private var newsHeaders = [NewsHeader]()
    private var filteredNewsHeaders = [NewsHeader]() {
        didSet {
            let differences = diff(old: oldValue, new: filteredNewsHeaders)
            var deletions = [IndexPath]()
            var insertions = [IndexPath]()
            for difference in differences {
                if let deletion = difference.delete?.index {
                    deletions.append(IndexPath(row: deletion, section: 0))
                }
                if let insertion = difference.insert?.index {
                    insertions.append(IndexPath(row: insertion, section: 0))
                }
            }
            if !deletions.isEmpty {
                tableView.deleteRows(at: deletions, with: .fade)
            }
            if !insertions.isEmpty {
                tableView.insertRows(at: insertions, with: .automatic)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        newsHeaderFacade.getNewsHeaders {
            self.newsHeaders = $0
            self.filteredNewsHeaders = $0
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
        filteredNewsHeaders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as NewsHeaderCellView
        let newsHeader = filteredNewsHeaders[indexPath.row]
        cell.setup(with: newsHeader)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == newsHeaders.count - 3 && searchController.searchBar.text?.isEmpty ?? false else {
            return
        }
        newsHeaderFacade.loadMore()
    }

    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHeader = newsHeaders[indexPath.row]
        let viewController = NewsDetailsViewController.instantiate() as NewsDetailsViewController
        tableView.deselectRow(at: indexPath, animated: false)
        if selectedHeader.content == nil {
            navigationController?.pushViewController(viewController, animated: true)
            if let contentUrl = URL(string: "https://loripsum.net/api/\(selectedHeader.articleSize)/short/plaintext") {
                URLSession.shared.dataTask(with: contentUrl) { data, _, _ in
                    if let data = data {
                        DispatchQueue.main.async {
                            selectedHeader.content = String(decoding: data, as: UTF8.self)
                            viewController.newsHeader = selectedHeader
                            viewController.showDetails()
                            self.newsHeaderFacade.update(selectedHeader)
                        }
                    }
                }
                .resume()
            }
        } else {
            viewController.newsHeader = selectedHeader
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    @objc private func refreshData() {
        newsHeaderFacade.getNewsHeaders {
            self.newsHeaders = $0
            self.tableView.reloadData()
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredNewsHeaders = searchText.isEmpty ? newsHeaders : newsHeaders.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        } else {
            filteredNewsHeaders = newsHeaders
        }
    }

}
