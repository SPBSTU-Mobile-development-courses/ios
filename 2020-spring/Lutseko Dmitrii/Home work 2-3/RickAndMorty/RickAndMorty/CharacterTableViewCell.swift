import UIKit
class CharacterTableViewCell: UITableViewCell {
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var label:UILabel?
    private var avatarLoadTask: URLSessionTask?

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    func setup(with character: Character) {
        label?.text = character.name
        avatarImageView.image = nil
        guard let imageUrl = URL(string: character.image) else { return }
        avatarLoadTask = URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
        avatarLoadTask?.resume()
    }
}
