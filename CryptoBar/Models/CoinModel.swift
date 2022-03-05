//
//  Coin.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 03.03.2022.
//

import Foundation

struct Coin: Identifiable, Hashable {
    let type: CoinType
    let value: Double
    let id = UUID()

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
}

extension Coin: CustomStringConvertible {
    var description: String { "\(type.ticker) (\(value))" }
}
