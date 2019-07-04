//
//  UserServiceNetwork.swift
//  UsersInformation
//
//  Created by Artem on 19/03/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import Alamofire
import RealmSwift

class UserServiceNetwork: UserService {
    let rootURL = "http://bolart.ru:3012/people/"

    func getUser(login: String, password: String, _ completionHandler: @escaping ((User?) -> Void)) {
        let url = rootURL + login + "/" + password
        request(url).responseData {
            switch $0.result {
            case let .success(data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try? jsonDecoder.decode(User.self, from: data)
                completionHandler(user)
            case let .failure(error):
                let usersRealm = UsersRealm()
                let usersInRealm = usersRealm.getUsers()
                if login == UserDefaults.standard.string(forKey: "login") && (password == UserDefaults.standard.string(forKey: "password")) {
                    completionHandler(usersInRealm)
                    print("Error: \(error)")
                } else {
                    completionHandler(nil)
                }
            }
        }
    }

    func getUsers(url: String?, _ completionHandler: @escaping (([User]) -> Void)) {
        guard let url = url else { return }
        request(url).responseData {
            switch $0.result {
            case let .success(data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let users = try? jsonDecoder.decode(Users.self, from: data)
                completionHandler(users ?? [])
            case let .failure(error):
                let allUsersRealm = AllUsersRealm()
                let allUsersInRealm = allUsersRealm.getAllUsers()
                completionHandler(allUsersInRealm)
                print("Error: \(error)")
            }
        }
    }

    func sendUser(user: User?, _ completionHandler: @escaping ((Bool) -> Void)) {
        let url = URL(string: rootURL)
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
