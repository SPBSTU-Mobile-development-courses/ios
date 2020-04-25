import UIKit
import Alamofire

class DetailViewController: UIViewController {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var avatarImage: UIImageView!
    
    var character: Character!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetail()
    }
    
    func setUpDetail() {
        nameLabel.text = character.name
        guard let url = character.imageUrl else { return }
        Alamofire.request(url).responseData { response in
            if response.error != nil {
                print(response.result)
            }
            if let data = response.data {
                self.avatarImage.image = UIImage(data: data)
            }
        }
    }
}
