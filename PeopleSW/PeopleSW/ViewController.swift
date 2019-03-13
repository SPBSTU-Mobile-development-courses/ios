import UIKit

class ViewController: UITableViewController {
    private let pageService: PeopleService = PeopleServiceNetwork()
    private let identifier = "PeopleTableViewCell"
    private var page = [Person]()
    private var nextUrl: String? = "https://swapi.co/api/people"

    private func getNewInformation() {
        pageService.getPage(url: nextUrl) { page, nextUrl in
            self.page.append(contentsOf: page)
            self.nextUrl = nextUrl
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getNewInformation()
        return
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == page.count - 1) && (nextUrl != nil) {
            self.getNewInformation()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        guard let cell = sender as? UITableViewCell else { return }
        let indexPathRow = tableView.indexPath(for: cell)?.row
        if let indexPath = indexPathRow {
            detailViewController.person = page[indexPath]
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return page.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = page[indexPath.row].name
        return cell
    }
}
