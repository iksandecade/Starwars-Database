//
//  NetworkManager.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import Foundation
import Reachability

class NetworkManager: NSObject {
    var reachbility: Reachability?
    
    static let sharedInstance: NetworkManager = { return NetworkManager() }()
    
    override init() {
        super.init()
        do {
            reachbility = try Reachability()
            NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: .reachabilityChanged, object: reachbility)
            try reachbility?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        
    }
    
    static func stopNotifier() -> Void {
        do {
            try (NetworkManager.sharedInstance.reachbility)?.startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    static func isReachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachbility)?.connection != Reachability.Connection.unavailable {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachbility)?.connection == Reachability.Connection.unavailable {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    static func isOnline() -> Bool {
        if (NetworkManager.sharedInstance.reachbility)?.connection == Reachability.Connection.unavailable {
            return false
        } else {
            return true
        }
    }
    
    static func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachbility)?.connection == .cellular {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachbility)?.connection == .wifi {
            completed(NetworkManager.sharedInstance)
        }
    }
}
