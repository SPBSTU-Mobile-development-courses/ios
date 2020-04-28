import UIKit

import Kingfisher
import Reusable

class NewsHeaderCellView: UITableViewCell, NibReusable {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var titleImage: UIImageView!

    override func prepareForReuse() {
        titleImage.image = nil
        titleImage.kf.cancelDownloadTask()
        super.prepareForReuse()
    }

    func setup(with newsHeader: NewsHeader) {
        titleImage.showAnimatedGradientSkeleton()
        authorLabel.text = newsHeader.author
        titleLabel.text = newsHeader.title
        guard let imageUrl = URL(string: newsHeader.image) else {
            return
        }
        titleImage.kf.setImage(with: imageUrl) { _ in
            self.titleImage.hideSkeleton()
        }
    }

}
