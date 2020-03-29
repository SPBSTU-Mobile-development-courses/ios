//
//  Current.swift
//  HomeTaskNumberOne
//
//  Created by Максим Егоров on 15/03/2019.
//  Copyright © 2019 Максим Егоров. All rights reserved.
//

struct Current: Decodable {
    let tempC: Int
    let tempF: Double
    let windMph, windKph: Double
    let windDir: String
    let humidity, cloud: Int
    let feelslikeC, feelslikeF: Double

    let text, icon: String
    let code: Int

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case tempF = "temp_f"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDir = "wind_dir"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
    }

    enum ConditionCodingKeys: String, CodingKey {
        case text
        case icon
        case code
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.tempC = try container.decode(Int.self, forKey: .tempC)
        self.tempF = try container.decode(Double.self, forKey: .tempF)
        self.windMph = try container.decode(Double.self, forKey: .windMph)
        self.windKph = try container.decode(Double.self, forKey: .windKph)
        self.windDir = try container.decode(String.self, forKey: .windDir)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.cloud = try container.decode(Int.self, forKey: .cloud)
        self.feelslikeC = try container.decode(Double.self, forKey: .feelslikeC)
        self.feelslikeF = try container.decode(Double.self, forKey: .feelslikeF)

        let conditionContainer = try container.nestedContainer(keyedBy: ConditionCodingKeys.self, forKey: .condition)

        self.text = try conditionContainer.decode(String.self, forKey: .text)
        self.icon = try conditionContainer.decode(String.self, forKey: .icon)
        self.code = try conditionContainer.decode(Int.self, forKey: .code)
    }
}
