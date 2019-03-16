//
//  Location.swift
//  HomeTaskNumberOne
//
//  Created by Максим Егоров on 15/03/2019.
//  Copyright © 2019 Максим Егоров. All rights reserved.
//

import Foundation
import Alamofire

struct Location: Codable {
    let name, region, country: String
    
    enum CodingKeys: String, CodingKey {
        case name, region, country
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.region = try container.decode(String.self, forKey: .region)
        self.country = try container.decode(String.self, forKey: .country)
    }
}
