//
//  CoinType.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 03.03.2022.
//

import Foundation
import SwiftUI

enum CoinType: String, Identifiable, Hashable, CaseIterable {
    case bitcoin
    case ethereum
    case bnb = "binance-coin"
    case monero
    case litecoin
    case dogecoin

    var ticker: String {
        switch self {
        case .bitcoin:
            return "BTC"
        case .ethereum:
            return "ETH"
        case .bnb:
            return "BNB"
        case .monero:
            return "XMR"
        case .litecoin:
            return "LTC"
        case .dogecoin:
            return "DOGE"
        }
    }

    var id: Self { self }
}
