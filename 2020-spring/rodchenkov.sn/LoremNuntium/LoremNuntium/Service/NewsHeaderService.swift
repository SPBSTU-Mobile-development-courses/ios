import Foundation

class NewsHeaderService: NHService {

    private var page = 1

    func getNewsHeaders(onCompletion: @escaping ([NewsHeader]) -> Void) {
        guard let apiUrl = URL(string: "https://picsum.photos/v2/list?page=\(page)&limit=20/") else {
            onCompletion([])
            return
        }
        page += 1
        URLSession.shared.dataTask(with: apiUrl) { data, _, _ in
            guard let data = data,
                let newsHeaders = try? JSONDecoder().decode([NewsHeader].self, from: data) else {
                    onCompletion([])
                    return
            }
            onCompletion(newsHeaders)
        }
        .resume()
    }

}
