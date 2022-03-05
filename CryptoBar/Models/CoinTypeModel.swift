//
//  CoinType.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 03.03.2022.
//

import Foundation
import SwiftUI

enum CoinType: String, Identifiable, CaseIterable {
    case bitcoin
    case ethereum
    case monero
    case litecoin
    case dogecoin

    var ticker: String {
        switch self {
        case .bitcoin:
            return "BTC"
        case .ethereum:
            return "ETH"
        case .monero:
            return "MON"
        case .litecoin:
            return "LTC"
        case .dogecoin:
            return "DOG"
        }
    }

    var color: Color {
        switch self {
        case .bitcoin:
            return .orange
        case .ethereum:
            return .purple
        case .monero:
            return .brown
        case .litecoin:
            return .blue
        case .dogecoin:
            return .yellow
        }
    }

    var id: Self { self }
    var url: URL { URL(string: "https://coincap.io/assets/\(rawValue)")! }
    var description: String { rawValue.capitalized }
}
