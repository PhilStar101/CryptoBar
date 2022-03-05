//
//  PriceService.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 03.03.2022.
//

import Combine
import Foundation
import Network

class PriceService: NSObject {
    private let session = URLSession(configuration: .default)
    private var wsTask: URLSessionWebSocketTask?

    let coinsSubject = CurrentValueSubject<[CoinType: Coin], Never>([:])
    var coins: [CoinType: Coin] {
        get {
            coinsSubject.value
        }
        set {
            coinsSubject.value = newValue
        }
    }

    let connectionSubject = CurrentValueSubject<Bool, Never>(true)
    var isConnected: Bool { connectionSubject.value }

    private var continuePing = true
    private var reconnectionDelay: Double {
        return continuePing ? 5 : 15
    }

    private let monitor = NWPathMonitor()

    func recieveMessage() {
        wsTask?.receive { [weak self] result in
            // TODO: replace with error
            guard let self = self else { return }

            switch result {
            case .success(let message):
                switch message {
                case .string(let string):
                    // TODO: replace with error
                    guard let jsonData = string.data(using: .utf8) else { return }
                    self.decodeData(for: jsonData)
                case .data(let jsonData):
                    self.decodeData(for: jsonData)
                @unknown default:
                    // TODO: replace with error
                    print("Failure in message switch")
                }
                self.recieveMessage()
            case .failure(let error):
                // TODO: replace with error
                print("Failure \(error.localizedDescription)")
            }
        }
    }

    func decodeData(for jsonData: Data) {
        guard let parsedDictionary = try? JSONSerialization.jsonObject(with: jsonData,
                                                                       options: .fragmentsAllowed) as? [String: Any]
        else { return }

        var newCoins = [CoinType: Coin]()
        let parsedCoins = Coin.makeDictionary(from: parsedDictionary)

        parsedCoins.forEach { coinType, coin in
            newCoins[coinType] = coin
        }
        let mergedDictionary = coins.merging(newCoins) { $1 }
        coins = mergedDictionary

//        coins = (Array(Set(Coin.makeArray(from: dictionary) + coins)))
    }

    func schedulePing() {
        // TODO: replace with error
        guard let wsTask = wsTask,
              continuePing
        else { return }

        let identifier = wsTask.taskIdentifier
        DispatchQueue.main.asyncAfter(deadline: .now() + reconnectionDelay) { [weak self] in
            // TODO: replace with error
            guard let self = self,
                  let wsTask = self.wsTask,
                  wsTask.taskIdentifier == identifier
            else { return }

            if wsTask.state == .running,
               self.continuePing
            {
                wsTask.sendPing { [weak self] error in
                    if error != nil {
                        print("Ping failed")
                        self?.continuePing = false
                    } else if self?.wsTask?.taskIdentifier == identifier {
                        print("Ping worked")
                        self?.continuePing = true
                    }
                }
                self.schedulePing()
            } else {
                self.reconnect()
            }
        }
    }

    func setupMonitorNetworkConnectivity() {
        monitor.pathUpdateHandler = { [weak self] path in
            // TODO: replace with error
            guard let self = self else { return }
            print("Called pathUpdateHandler \(path)")

            if path.status == .satisfied, self.wsTask == nil {
                self._connect()
            }

            if path.status == .unsatisfied {
                self.clearConnection()
            }
        }
        monitor.start(queue: .main)
    }

    func reconnect() {
        clearConnection()
        _connect()
    }

    func clearConnection() {
        wsTask?.cancel(with: .goingAway, reason: .none)
        wsTask = nil
        continuePing = false
        connectionSubject.send(false)
    }

    deinit {
        coinsSubject.send(completion: .finished)
        connectionSubject.send(completion: .finished)
    }
}

// MARK: - CONNECTION

extension PriceService: URLSessionWebSocketDelegate {
    private func _connect() {
        // TODO: replace with error
        guard monitor.currentPath.status == .satisfied else { return }
        let coins = CoinType
            .allCases
            .map { $0.rawValue }
            .joined(separator: ",")

        guard let url = URL(string: "wss://ws.coincap.io/prices?assets=\(coins)") else { return }
//        guard let url = URL(string: "ws://localhost:8080") else { return }
        wsTask = session.webSocketTask(with: url)
        wsTask?.delegate = self
        wsTask?.resume()
        recieveMessage()
    }

    func connect() -> Self {
        _connect()
        return self
    }

    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        continuePing = monitor.currentPath.status == .satisfied
        schedulePing()
        connectionSubject.send(true)
    }

    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        continuePing = false
        connectionSubject.send(false)
    }
}
