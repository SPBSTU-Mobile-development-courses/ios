import Alamofire
import Foundation

class PeopleServiceNetwork: PeopleService {
    func getPage(url: String?, _ completionHandler: @escaping (([Person], String?) -> Void)) {
        var people = [Person]()
        var next: String?
        guard let url = url else { return }
        request(url).responseData {
            switch $0.result {
            case let .success(data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let page = try? jsonDecoder.decode(Page.self, from: data)
                if let page = page {
                    for newPerson in page.results {
                        people.append(newPerson)
                    }
                }
                next = page?.next
                completionHandler(people, next)
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
