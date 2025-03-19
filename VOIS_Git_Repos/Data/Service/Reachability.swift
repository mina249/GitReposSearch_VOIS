//
//  Reachability.swift
//  VOIS_Git_Repos
//
//  Created by Mina Nageh on 19/03/2025.
//

import Network

class Reachability {
    static let shared = Reachability()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    private var isConnected = false
    
    private init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = (path.status == .satisfied)
        }
        monitor.start(queue: queue)
    }
    
    func isConnectedToInternet() -> Bool {
        return isConnected
    }
}
