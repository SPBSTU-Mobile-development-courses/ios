import UIKit

class CharacterDetailViewController: UIViewController {
    @IBOutlet var characterDetailView: CharacterDetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet var name: UILabel!
    @IBOutlet var avatarView: UIImageView!
    
    func setup(with characterCell: CharacterTableViewCell) {
        name.text = characterCell.label.text
        avatarView.image = characterCell.avatarView.image
    }
}
