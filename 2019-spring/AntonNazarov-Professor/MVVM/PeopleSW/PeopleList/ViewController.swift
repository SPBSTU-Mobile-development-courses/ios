import UIKit

class ViewController: UITableViewController {
    private let identifier = "PeopleTableViewCell"
    private var page = [Person]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var viewModel: PeopleListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onPeopleChanged = { [unowned self] in
            self.page = $0
        }
        viewModel.loadMore()
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == page.count - 1 {
            viewModel.loadMore()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        let detailViewController = mainStoryboard.instantiateInitialViewController() as! DetailViewController
        detailViewController.person = page[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let detailViewController = segue.destination as? DetailViewController else { return }
//        guard let cell = sender as? UITableViewCell else { return }
//        let indexPathRow = tableView.indexPath(for: cell)?.row
//        if let indexPath = indexPathRow {
//            detailViewController.person = page[indexPath]
//        }
//    }

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
