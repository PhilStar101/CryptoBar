//
//  PriceService.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 03.03.2022.
//

import Combine
import Foundation

class PriceService {
    private let session = URLSession(configuration: .default)
    private var wsTast: URLSessionDataTask?

    private let coinDictionarySubject = CurrentValueSubject<[String: Coin], Never>([:])
    private var coinDictionary: [String: Coin] { coinDictionarySubject.value }

    private let connectionSubject = CurrentValueSubject<Bool, Never>(false)
    private var isConnected: Bool { connectionSubject.value }

    deinit {
        coinDictionarySubject.send(completion: .finished)
        connectionSubject.send(completion: .finished)
    }
}
