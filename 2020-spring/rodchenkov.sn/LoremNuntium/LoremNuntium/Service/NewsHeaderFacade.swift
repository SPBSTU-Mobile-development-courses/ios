import RealmSwift

class NewsHeaderFacade {

    private let newsHeaderService = NewsHeaderService()
    private let newsHeaderRepository = NewsHeaderRepository()

    private var notificationToken: NotificationToken?

    func loadMore() {
        newsHeaderService.getNewsHeaders {
            self.newsHeaderRepository.save($0)
        }
    }

    func getNewsHeaders(completion: @escaping ([NewsHeader]) -> Void) {
        loadMore()
        let results = newsHeaderRepository.load()
        notificationToken = results.observe { _ in
            completion(results.map {
                $0.newsHeader
            })
        }
    }

    func update(_ item: NewsHeader) {
        newsHeaderRepository.save([item])
    }

}
