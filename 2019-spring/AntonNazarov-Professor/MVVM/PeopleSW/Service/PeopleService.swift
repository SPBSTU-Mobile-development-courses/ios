protocol PeopleService {
    func getPage(url: String?, _ completionHandler: @escaping (([Person], String?) -> Void))
}
