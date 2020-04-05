import Foundation

class CharacterService {
    private let baseURL = "https://rickandmortyapi.com/api/character/"
    private var nextURL: URL?
    
    func getCharacters(url: URL, completion: @escaping ([Character]?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, _) in
            guard let data = data, let page = try? JSONDecoder().decode(Page<Character>.self, from: data) else {
                completion(nil)
                return
            }
            self.nextURL = URL(string: page.info.next)
            completion(page.results)
        })
        .resume()
    }
    
    func getCharacters(completion: @escaping ([Character]?) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(nil)
            return
        }
        getCharacters(url: url, completion: completion)
    }

    func getMoreCharacters(completion: @escaping ([Character]?) -> Void) {
        guard let url = nextURL else {
            completion(nil)
            return
        }
        getCharacters(url: url, completion: completion)
    }}
