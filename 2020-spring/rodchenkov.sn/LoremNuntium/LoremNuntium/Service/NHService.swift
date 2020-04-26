protocol NHService {
    func getNewsHeaders(onCompletion: @escaping ([NewsHeader]) -> Void)
}
