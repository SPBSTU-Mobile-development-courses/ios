import UIKit

class ViewController: UITableViewController {
    private let pageService: PageService = PageServiceNetwork()
    private let identifier = "PageTableViewCell"
    private var page = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        pageService.getPage { page in
            self.page = page
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        return
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
