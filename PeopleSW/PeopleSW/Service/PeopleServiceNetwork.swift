import Alamofire
import Foundation

class PeopleServiceNetwork: PeopleService {
    func getPeoples(_ completionHandler: @escaping (([People]) -> Void)) {
        request("https://swapi.co/api/people").responseData {
            switch $0.result {
            case let .success(data):
                let jsonDecoder = JSONDecoder()
                let peoples = try? jsonDecoder.decode(Peoples.self, from: data)
                let peoples1 = peoples?.results.map { keyValue -> People in
                    let (people) = keyValue
                    // swiftlint:disable:next multiline_arguments_brackets multiline_arguments
                    return People(name: people.name, height: people.height, mass: people.mass, hairColor: people.hairColor,
                                  // swiftlint:disable:next multiline_arguments
                                  skinColor: people.skinColor, eyeColor: people.eyeColor, birthYear: people.birthYear, gender: people.gender,
                                  // swiftlint:disable:next multiline_arguments
                                  homeworld: people.homeworld, films: people.films, species: people.species, vehicles: people.vehicles,
                                  // swiftlint:disable:next multiline_arguments_brackets multiline_arguments
                                  starships: people.starships, created: people.created, edited: people.edited, url: people.url)
                }
                completionHandler(peoples1 ?? [])
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
