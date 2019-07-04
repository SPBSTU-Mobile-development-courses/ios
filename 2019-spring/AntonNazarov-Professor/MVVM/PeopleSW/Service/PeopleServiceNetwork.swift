import Alamofire
import Foundation

class PeopleServiceNetwork: PeopleService {
    func getPage(url: String?, _ completionHandler: @escaping (([Person], String?) -> Void)) {
        guard let url = url else { return }
        request(url).responseData {
            switch $0.result {
            case let .success(data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let page = try? jsonDecoder.decode(Page.self, from: data)
                guard let resultPage = page else { return }
                completionHandler(resultPage.results, resultPage.next)
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
