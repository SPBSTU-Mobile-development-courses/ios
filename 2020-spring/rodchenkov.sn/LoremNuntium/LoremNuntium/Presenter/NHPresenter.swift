import DeepDiff

protocol NHPresenter {
    func getNewsHeaders(completion: @escaping ([NewsHeader]) -> Void)
    func loadMore()
    func loadContent(_ selectedHeader: NewsHeader, _ completion: @escaping () -> Void)
    func filter(infix: String) -> [NewsHeader]
    func getDiff(old: [NewsHeader], new: [NewsHeader]) -> (insertions: [IndexPath], deletions: [IndexPath])
}
