import UIKit

class ViewController: UITableViewController {
    let peopleService: PeopleService = PeopleServiceNetwork()
    let identifier = "PeopleTableViewCell"
    var peoples = [People]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        guard peoples.count > 1 else {
            peopleService.getPeoples { peoples in
                self.peoples = peoples
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            return
        }
        self.tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get a reference to the second view controller
        // swiftlint:disable:next force_cast
        let detailViewController = segue.destination as! DetailViewController
        // swiftlint:disable:next force_cast
        let cell = sender as! UITableViewCell
        let indexPathRow = tableView.indexPath(for: cell)?.row

        // set a variable in the second view controller with the String to pass
        detailViewController.peoples = peoples
        if let indexPath = indexPathRow {
            detailViewController.index = indexPath
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peoples.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = peoples[indexPath.row].name
        return cell
    }
}
