import Alamofire
import Foundation

class PageServiceNetwork: PageService {
    func getPage(_ completionHandler: @escaping (([Person]) -> Void)) {
        request("https://swapi.co/api/people").responseData {
            switch $0.result {
            case let .success(data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let page = try? jsonDecoder.decode(Page.self, from: data)
                completionHandler(page?.results ?? [])
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
