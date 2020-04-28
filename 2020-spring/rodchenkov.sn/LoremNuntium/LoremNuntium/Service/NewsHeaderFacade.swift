import RealmSwift

class NewsHeaderFacade: NHFacade {

    private let newsHeaderService: NHService
    private let newsHeaderRepository: NHRepository

    private var notificationToken: NotificationToken?

    init(_ newsHeaderService: NHService, _ newsHeaderRepository: NHRepository) {
        self.newsHeaderRepository = newsHeaderRepository
        self.newsHeaderService = newsHeaderService
    }

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

    func loadContent(_ selectedHeader: NewsHeader, _ completion: @escaping () -> Void) {
        if let contentUrl = URL(string: "https://loripsum.net/api/\(selectedHeader.articleSize)/short/plaintext") {
            URLSession.shared.dataTask(with: contentUrl) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        selectedHeader.content = String(decoding: data, as: UTF8.self)
                        self.newsHeaderRepository.save([selectedHeader])
                        completion()
                    }
                }
            }
            .resume()
        }
    }

}
