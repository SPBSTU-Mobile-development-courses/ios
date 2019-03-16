
import Foundation
import Alamofire

class WeatherServiceNetwork: WeatherService {
    
    func getCurrentWeather(location : String, _ completionHandler: @escaping ((Weather) -> Void)) {
      
        let url = "http://api.apixu.com/v1/current.json?key=94f1763d0042416fa7b141450191103&q=\(location)"
        request(url).responseData {
            switch $0.result {
            case let .success(data):
                let jsonDecoder = JSONDecoder()
                guard let weather = try? jsonDecoder.decode(Weather.self, from: data)
                    else{
                        return
                }
                completionHandler(weather)
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
    
    func getIcon(url: String, completionHandler: @escaping ((UIImage) -> Void)) {
        let icon = UIImageView()
        let h = "https:"
        let url = URL(string: h+url)
        if let data = try? Data(contentsOf: url!) {
            icon.image = UIImage(data: data)
        }
        completionHandler(icon.image!)
    }
    
}
