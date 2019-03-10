import UIKit

class DetailViewController: UIViewController, UITableViewDataSource {
    @IBOutlet private var labelPeopleName: UILabel!
    @IBOutlet private var tableView: UITableView!

    @IBAction private func closeButton(_ sender: UIButton) {
    }

    let identifier = "PeopleTableViewCell"
    var peoples = [People]()
    var prop: [String] = []
    var titles: [String] = []
    var index: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        let targetPeople = peoples[index]
        labelPeopleName.text = targetPeople.name
        prop = [ targetPeople.gender, targetPeople.birthYear, targetPeople.hairColor, targetPeople.height, targetPeople.mass, targetPeople.skinColor ]
        titles = [ "Gender", "Birth Year", "Hair Color", "Height", "Mass", "Skin Color" ]
        tableView.dataSource = self
        tableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        cell.detailTextLabel?.text = prop[indexPath.row]
        return cell
    }
}
