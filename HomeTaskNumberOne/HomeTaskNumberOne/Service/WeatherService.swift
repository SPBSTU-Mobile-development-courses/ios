
import Foundation

protocol WeatherService {
    func getCurrentWeather(location : String, _ completionHandler: @escaping ((Weather) -> Void))
}
