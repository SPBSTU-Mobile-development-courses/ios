import DeepDiff

class NewsHeaderPresenter: NHPresenter {

    private let newsHeaderFacade: NHFacade

    private var newsHeaders = [NewsHeader]()

    init(_ newsHeaderFacade: NHFacade) {
        self.newsHeaderFacade = newsHeaderFacade
    }

    func getNewsHeaders(completion: @escaping ([NewsHeader]) -> Void) {
        newsHeaderFacade.getNewsHeaders {
            self.newsHeaders = $0
            completion($0)
        }
    }

    func loadMore() {
        newsHeaderFacade.loadMore()
    }

    func loadContent(_ selectedHeader: NewsHeader, _ completion: @escaping () -> Void) {
        newsHeaderFacade.loadContent(selectedHeader, completion)
    }

    func filter(infix: String) -> [NewsHeader] {
        infix.isEmpty ? newsHeaders : newsHeaders.filter {
            $0.title.lowercased().contains(infix.lowercased())
        }
    }

    func getDiff(old: [NewsHeader], new: [NewsHeader]) -> (insertions: [IndexPath], deletions: [IndexPath]) {
        let differences = diff(old: old, new: new)
        var deletions = [IndexPath]()
        var insertions = [IndexPath]()
        for difference in differences {
            if let deletion = difference.delete?.index {
                deletions.append(IndexPath(row: deletion, section: 0))
            }
            if let insertion = difference.insert?.index {
                insertions.append(IndexPath(row: insertion, section: 0))
            }
        }
       return (insertions, deletions)
    }

    func showDetailsScreen(for selectedHeader: NewsHeader, on navigationController: UINavigationController?) {
        let viewController = NewsDetailsViewController.instantiate() as NewsDetailsViewController
        if selectedHeader.content == nil {
            navigationController?.pushViewController(viewController, animated: true)
            loadContent(selectedHeader) {
                viewController.newsHeader = selectedHeader
                viewController.showDetails()
            }
        } else {
            viewController.newsHeader = selectedHeader
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

}
