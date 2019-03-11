protocol PageService {
    func getPage(_ completionHandler: @escaping (([Person]) -> Void))
}
