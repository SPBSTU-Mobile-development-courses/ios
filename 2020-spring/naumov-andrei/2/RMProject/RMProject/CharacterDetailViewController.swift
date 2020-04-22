import Kingfisher
import UIKit

class CharacterDetailViewController: UIViewController {
    @IBOutlet private var name: UILabel!
    @IBOutlet private var avatarView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avatarView.kf.cancelDownloadTask()
    }

    func setup(with character: Character) {
        name.text = character.name
        guard let imageURL = character.imageURL else { return }
        avatarView.kf.setImage(with: imageURL)
    }
}
