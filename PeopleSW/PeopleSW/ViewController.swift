import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet private var tableView: UITableView!
    private let pageService: PeopleService = PeopleServiceNetwork()
    private let identifier = "PeopleTableViewCell"
    private var page = [Person]()
    private var nextUrl: String? = "https://swapi.co/api/people"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        pageService.getPage(url: nextUrl) { page, nextUrl in
            for newPerson in page {
                self.page.append(newPerson)
            }
            self.nextUrl = nextUrl
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        return
    }

    @IBAction private func buttonMore(_ sender: UIButton) {
        tableView.dataSource = self
        pageService.getPage(url: nextUrl) { page, nextUrl in
            for newPerson in page {
                self.page.append(newPerson)
            }
            self.nextUrl = nextUrl
            DispatchQueue.main.async {
                self.tableView.reloadData()
                let ipath = IndexPath(row: self.page.count - 1, section: 0)
                self.tableView.scrollToRow(at: ipath as IndexPath, at: .bottom, animated: true)
            }
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return page.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = page[indexPath.row].name
        return cell
    }
}
