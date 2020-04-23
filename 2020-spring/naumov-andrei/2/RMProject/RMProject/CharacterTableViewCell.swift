import Kingfisher
import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet private var name: UILabel!
    @IBOutlet private var avatarView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        avatarView.image = nil
        avatarView.kf.cancelDownloadTask()
    }

    func setup(with character: Character) {
        name.text = character.name
        guard let imageURL = character.imageURL else { return }
        avatarView.kf.setImage(with: imageURL)
    }
}
