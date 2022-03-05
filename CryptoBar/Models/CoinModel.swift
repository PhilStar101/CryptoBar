//
//  Coin.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 03.03.2022.
//

import Foundation
import SwiftUI

struct Coin: Identifiable, Hashable {
    private let type: CoinType
    let value: Double
    let id = UUID()

    var color: Color {
        switch type {
        case .bitcoin:
            return .orange
        case .ethereum:
            return .purple
        case .bnb:
            return .orange
        case .monero:
            return .brown
        case .litecoin:
            return .blue
        case .dogecoin:
            return .yellow
        }
    }

    var url: URL { URL(string: "https://coincap.io/assets/\(type.rawValue)")! }

    static func == (lhs: Coin, rhs: Coin) -> Bool {
        return lhs.type == rhs.type
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
}

extension Coin {
    static func makeArray(from json: [String: Any]) -> [Coin] {
        var result: [Coin] = []

        for key in CoinType.allCases {
            // TODO: replace with error
            guard let doubleString = json[key.rawValue] as? String else { continue }

            if let value = Double(doubleString) {
                result.append(Coin(type: key, value: value))
            }
        }

        return result
    }

    static func makeDictionary(from json: [String: Any]) -> [CoinType: Coin] {
        var result: [CoinType: Coin] = [:]

        for key in CoinType.allCases {
            // TODO: replace with error
            guard let doubleString = json[key.rawValue] as? String else { continue }

            if let value = Double(doubleString) {
                result[key] = Coin(type: key, value: value)
            }
        }

        return result
    }
}

extension Coin: CustomStringConvertible {
    var description: String { "\(type.ticker) (\(value))" }
}
