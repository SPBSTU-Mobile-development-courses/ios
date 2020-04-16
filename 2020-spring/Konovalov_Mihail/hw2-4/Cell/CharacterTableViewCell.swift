import UIKit

final class CharacterTableViewCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var avatarImageView: UIImageView!
    private var avatarLoadTask: URLSessionTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        avatarLoadTask?.cancel()
    }
    
    func setup(with character: Character) {
        
        nameLabel.text = character.name
        guard let imageUrl = character.imageUrl else { return }
        avatarLoadTask = URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
        avatarLoadTask?.resume()
    }
}
