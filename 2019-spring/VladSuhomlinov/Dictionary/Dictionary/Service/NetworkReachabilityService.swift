//
//  NetworkReachabilityService.swift
//  Dictionary
//
//  Created by Мария on 28/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//

import Reachability
import UIKit

class NetworkReachabilityService {
    private var reachability: Reachability {
        guard let reachability = Reachability() else {
            fatalError("Reachability can't be initialized")
        }
        return reachability
    }
    var isNetworkConnected: Bool {
        return reachability.connection != .none
    }
    
    func getErrorNetworkAlertController(_ completionHandler: @escaping (UIAlertAction) -> Void) -> UIViewController {
        let alert = UIAlertController(title: "No internet connection", message: "Service is unavailable ", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Done", style: .cancel, handler: completionHandler)
        alert.addAction(closeAction)
        return alert
    }
    
    func startNotifier() {
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    func stopNotifier() {
        reachability.stopNotifier()
    }
}
