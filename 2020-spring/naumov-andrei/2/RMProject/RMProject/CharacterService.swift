import Foundation

protocol CharacterService {
    typealias CharactersCompletion = ([Character]?) -> Void

    func getCharacters(completion: @escaping CharactersCompletion)
    func getMoreCharacters(completion: @escaping CharactersCompletion)
}

class CharacterServiceImpl: CharacterService {
    private let baseURL = "https://rickandmortyapi.com/api/character/"
    private var nextURL: URL?

    func getCharacters(url: URL, completion: @escaping CharactersCompletion) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                let page = try? JSONDecoder().decode(Page<Character>.self, from: data)
                else {
                completion(nil)
                return
            }
            self.nextURL = URL(string: page.info.next)
            completion(page.results)
        }
        .resume()
    }

    func getCharacters(completion: @escaping CharactersCompletion) {
        guard let url = URL(string: baseURL) else {
            completion(nil)
            return
        }
        getCharacters(url: url, completion: completion)
    }

    func getMoreCharacters(completion: @escaping CharactersCompletion) {
        guard let url = nextURL else {
            completion(nil)
            return
        }
        getCharacters(url: url, completion: completion)
    }
}
