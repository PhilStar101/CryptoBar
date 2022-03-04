//
//  PriceService.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 03.03.2022.
//

import Combine
import Foundation

class PriceService: NSObject {
    private let session = URLSession(configuration: .default)
    private var wsTask: URLSessionWebSocketTask?

    private let coinDictionarySubject = CurrentValueSubject<[String: Coin], Never>([:])
    private var coinDictionary: [String: Coin] { coinDictionarySubject.value }

    private let connectionSubject = CurrentValueSubject<Bool, Never>(false)
    private var isConnected: Bool { connectionSubject.value }

    func connect() {
        let coins = CoinType
            .allCases
            .map { $0.rawValue }
            .joined(separator: ",")

        guard let url = URL(string: "wss://ws.coincap.io/prices?assets=\(coins)") else { return }
        wsTask = session.webSocketTask(with: url)
        wsTask?.delegate = self
        wsTask?.resume()
        recieveMessage()
    }

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
                    print(self.decodeData(for: jsonData))
                case .data(let jsonData):
                    print(self.decodeData(for: jsonData))
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

    func decodeData(for jsonData: Data) -> [Coin] {
        if let dictionary = try? JSONSerialization.jsonObject(with: jsonData,
                                                              options: .fragmentsAllowed) as? [String: Any]
        {
            return Coin.makeArray(from: dictionary)
        }
        return []
    }

    deinit {
        coinDictionarySubject.send(completion: .finished)
        connectionSubject.send(completion: .finished)
    }
}

extension PriceService: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {}

    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {}
}
