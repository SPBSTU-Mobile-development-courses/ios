protocol NHFacade {
    func loadMore()
    func getNewsHeaders(completion: @escaping ([NewsHeader]) -> Void)
    func loadContent(_ selectedHeader: NewsHeader, _ completion: @escaping () -> Void)
}
