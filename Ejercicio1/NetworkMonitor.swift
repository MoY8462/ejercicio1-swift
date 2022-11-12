//
//  NetworkMonitor.swift
//  Ejercicio1
//
//  Created by DISMOV on 12/11/22.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private var monitor: NWPathMonitor?
    private let queue = DispatchQueue.global()
    
    
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknow
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknow
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    public func startMonitoring() {
        self.monitor?.start(queue: queue)
        monitor?.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
    }
    
    public func stopMonitoring() {
        monitor?.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }
        else if path.usesInterfaceType(.cellular){
            connectionType = .cellular
        }
        else if path.usesInterfaceType(.wiredEthernet){
            connectionType = .ethernet
        }
        else {
            connectionType = .unknow
        }
    }
    
}
