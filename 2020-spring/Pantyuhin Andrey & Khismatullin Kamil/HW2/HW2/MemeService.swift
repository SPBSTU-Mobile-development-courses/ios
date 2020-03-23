//
//  MemeService.swift
//  HW2
//
//  Created by panandafog on 20.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//
import Foundation

class MemeService {
    typealias PostsCompletion = ([Post]?) -> Void
    private var currentPage: Int?
    
    func getURL(page: Int) -> String{
        print("THIS PAGE :",String(page))
        return("https://api.imgur.com/3/gallery/search/viral/all/" + String(page) + "?q=memes&q_type=jpg")
    }
    
    func getMemes(completion: @escaping PostsCompletion) {
        if (self.currentPage == nil) {
            self.currentPage = 0
        } else {
            self.currentPage! += 1
        }
        guard let page = self.currentPage else {
            completion(nil)
            print("wrong page number")
            return
        }
        guard let searchUrl = URL(string: getURL(page: page)) else {
            completion(nil)
            print("error in URL")
            return
        }
        var searchRequest = URLRequest(url: searchUrl)
        searchRequest.setValue("Client-ID c8828f10f679ec3", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: searchRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                print("error")
                return
            }
            guard var page = try? JSONDecoder().decode(Page.self, from: data) else {
                completion(nil)
                print("decode failed")
                return
            }
            
            guard var pageData = page.data else {
                completion(nil)
                print("decode failed")
                return
            }
            
            var index: Int = 0
            
            while index < page.data!.count {
                if page.data![index].images == nil {
                    page.data!.remove(at: index)
                } else {
                    if (page.data![index].images![0].type != "image/jpeg") && (page.data![index].images![0].type != "image/png") {
                        page.data!.remove(at: index)
                    }
                }
                
                index += 1
            }
                print(page.success)
                print(page.status)
                completion(page.data)
                //            completion(page.success)
            }.resume()
        }
}
