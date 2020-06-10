

import UIKit

class CountryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView:UITableView!
    private var countryArray:[Country] = [
        Country(name: "United Arab Emirates", url: "ae"),
        Country(name: "Argentina", url: "ar"),
        Country(name: "Austria", url: "at"),
        Country(name: "Australia", url: "au"),
        Country(name: "Belgium", url: "be"),
        Country(name: "Bulgaria", url: "bg"),
        Country(name: "Brazil", url: "br"),
        Country(name: "Colombia", url: "co"),
        Country(name: "Germany", url: "de"),
        Country(name: "France", url: "fr"),
        Country(name: "Russia", url: "ru"),
        Country(name: "USA", url: "us"),
        Country(name: "South Africa", url: "za"),
        Country(name: "Venezuela", url: "ve"),
        Country(name: "Slovakia", url: "sk")
    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        countryArray.sort{$0.countryName < $1.countryName}
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? ViewController)?.country = countryArray[tableView.indexPathForSelectedRow!.row].countyForUrl
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CountryCell", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        guard let newCell = cell as? CountryCell else {fatalError("Non casting to CountryCell")}
        let country = countryArray[indexPath.row]
        newCell.insert(string: country.countryName)
        return newCell
    }
}
