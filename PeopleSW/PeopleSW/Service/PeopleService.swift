protocol PeopleService {
    func getPage(_ completionHandler: @escaping (([Person]) -> Void))
}
