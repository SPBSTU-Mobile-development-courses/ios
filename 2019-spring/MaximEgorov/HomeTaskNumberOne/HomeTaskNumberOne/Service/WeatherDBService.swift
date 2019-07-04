//
//  WeatherInCellService.swift
//  HomeTaskNumberOne
//
//  Created by Максим Егоров on 19/03/2019.
//  Copyright © 2019 Максим Егоров. All rights reserved.
//

import RealmSwift

final class WeatherDBService {
    private var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("Realm can't be initialized")
        }
        return realm
    }

    func getAll() -> Results<WeatherDB> {
        return realm.objects(WeatherDB.self).sorted(byKeyPath: "createdAt", ascending: false)
    }

    func add(weather: Weather) {
        let realmWeather = WeatherDB()
        realmWeather.cityName = weather.location.name
        realmWeather.temperatureCelcius = weather.current.tempC
        realmWeather.temperatureFarenheit = weather.current.tempF
        realmWeather.windKph = weather.current.windKph
        realmWeather.windMph = weather.current.windMph
        realmWeather.windDirection = weather.current.windDir
        realmWeather.cloud = weather.current.cloud
        realmWeather.humidity = weather.current.humidity
        realmWeather.feelsLikeCelcius = weather.current.feelslikeC
        realmWeather.feelsLikeFarenheit = weather.current.feelslikeF
        realmWeather.imagePath = weather.current.icon
        realmWeather.text = weather.current.text

            try? realm.write {
                realm.add(realmWeather)
            }
    }

    func update(weather: WeatherDB, newWeather: Weather) {
        try? realm.write {
            weather.temperatureCelcius = newWeather.current.tempC
            weather.temperatureFarenheit = newWeather.current.tempF
            weather.windKph = newWeather.current.windKph
            weather.windMph = newWeather.current.windMph
            weather.windDirection = newWeather.current.windDir
            weather.cloud = newWeather.current.cloud
            weather.humidity = newWeather.current.humidity
            weather.feelsLikeCelcius = newWeather.current.feelslikeC
            weather.feelsLikeFarenheit = newWeather.current.feelslikeF
            weather.imagePath = newWeather.current.icon
            weather.text = newWeather.current.text
        }
    }

    func isExistingItem(cityName: String) -> Bool {
        let item = realm.objects(WeatherDB.self).filter("cityName BEGINSWITH '\(cityName)'")
        return item.isEmpty
    }

    func select(cityName: String) -> Results<WeatherDB>? {
        return realm.objects(WeatherDB.self).filter("cityName BEGINSWITH '\(cityName)'").sorted(byKeyPath: "createdAt", ascending: false)
    }

    func delete(city: WeatherDB) {
        try? realm.write {
            realm.delete(city)
        }
    }

    func deleteAll() {
        try? realm.write {
            realm.deleteAll()
        }
    }
}
