import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet var label: UILabel!
    @IBOutlet var avatarView: UIImageView!
    private var avatarLoadTask: URLSessionTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarLoadTask?.cancel()
    }
    
    func setup(with character: Character) {
        label.text = character.name
        avatarView.image = nil
        guard let imageURL = URL(string: character.image) else { return }
        avatarLoadTask = URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            guard let data = data, let picture = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.avatarView.image = picture
            }
        }
        avatarLoadTask?.resume()
    }
}
