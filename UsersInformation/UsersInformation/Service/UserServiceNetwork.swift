//
//  UserServiceNetwork.swift
//  UsersInformation
//
//  Created by Artem on 19/03/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import Alamofire
import Foundation

class UserServiceNetwork: UsersService {
    func getPage(url: String?, _ completionHandler: @escaping ((User?) -> Void)) {
        guard let url = url else { return }
        request(url).responseData {
            switch $0.result {
            case let .success(data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try? jsonDecoder.decode(User.self, from: data)
                completionHandler(user)
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }

    func sendUser(user: User?, _ completionHandler: @escaping ((Bool) -> Void)) {
        let url = URL(string: "http://bolart.ru:3012/people")
        let jsonCoder = JSONEncoder()
        do {
            let requestUser = try jsonCoder.encode(user)
            guard let url = url else { return }
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = requestUser
            Alamofire.request(request).responseJSON { response in
                if response.response?.statusCode == 200 {
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            }
        } catch {
            completionHandler(false)
        }
    }
}
