//
//  Double.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 05.03.2022.
//

import Foundation

extension Double {
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    func format() -> String {"$\(Double.formatter.string(from: NSNumber(value: self)) ?? "?")" }
}
