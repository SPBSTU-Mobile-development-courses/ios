protocol CharacterService {
    func getCharacter(url: String?, _ completionHandler: @escaping (([People], String?) -> Void))
}
