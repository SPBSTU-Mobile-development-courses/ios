import UIKit

import Reusable
import SkeletonView

class NewsDetailsViewController: UIViewController, StoryboardBased {

    var newsHeader: NewsHeader?

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var contentLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!

    @IBOutlet private var titleImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if newsHeader != nil {
            showDetails()
            return
        }
        [titleLabel, contentLabel, authorLabel, titleImage].forEach {
            $0?.showAnimatedGradientSkeleton()
        }
    }

    func showDetails() {
        guard let newsHeader = newsHeader else {
            return
        }
        [titleLabel, contentLabel, authorLabel].forEach {
            $0?.hideSkeleton()
        }
        titleLabel.text = newsHeader.title
        contentLabel.text = newsHeader.content ?? "Nothing to show"
        authorLabel.text = newsHeader.author
        if let imageUrl = URL(string: newsHeader.image) {
            titleImage.kf.setImage(with: imageUrl) { _ in
                self.titleImage.hideSkeleton()
            }
        }
    }

}
