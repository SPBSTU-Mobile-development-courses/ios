import Foundation
import UIKit

class CharacterDetailView: UIView {
    @IBOutlet var name: UILabel!
    @IBOutlet var avatarView: UIImageView!
    
    func setup(with characterCell: CharacterTableViewCell) {
        name.text = characterCell.label.text
        avatarView.image = characterCell.avatarView.image
    }
}
