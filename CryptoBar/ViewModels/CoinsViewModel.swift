//
//  MenuBarViewModel.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 04.03.2022.
//

import Combine
import Foundation
import SwiftUI

class CoinsViewModel: ObservableObject {
    var coinTypes: [CoinType] {
        CoinType.allCases.filter { coins[$0] != nil }
    }

    @Published var coins: [CoinType: Coin] = [:]
    @Published var value: String = "..."
    @Published var type: CoinType = .bnb
    @Published var color: Color = .orange
    @Published var isError: Bool = false

    @AppStorage("SelectedCoinType") var selectedCoinType: CoinType = .bnb

    let service: PriceService
    private var subscriptions = Set<AnyCancellable>()

    init(service: PriceService) {
        self.service = service
    }

    func subscribeToService() {
        service.coinsSubject
            .combineLatest(service.connectionSubject)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.updateView() }
            .store(in: &subscriptions)
    }

    func updateView() {
        if service.isConnected {
            isError = false
            coins = service.coins
            let selectedCoinRecord = service.coins.first { $0.key == selectedCoinType }
            guard let selectedCoinRecord = selectedCoinRecord else {
                value = "..."
                return
            }
            let coin = selectedCoinRecord.value

            type = selectedCoinRecord.key
            value = coin.value.format()
            color = coin.color
        } else {
            isError = true
            value = "Offline"
        }
    }
}
