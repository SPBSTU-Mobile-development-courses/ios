import Alamofire
import Foundation

class CharacterDataNetwork: CharacterService {
    func getCharacter(url: String?, _ completionHandler: @escaping (([People], String?) -> Void)) {
        var characters = [People]()
        var next: String?
        guard let url = url else { return }
        request(url).responseData {
            switch $0.result {
            case let .success(data):
                let jsonDecoder = JSONDecoder()
               // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let character = try? jsonDecoder.decode(CharacterInfo.self, from: data)
                    if let character = character {
                        for newCharacter in character.results {
                        characters.append(newCharacter)
                    }
                }
                next = character?.next
                completionHandler(characters, next)
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
