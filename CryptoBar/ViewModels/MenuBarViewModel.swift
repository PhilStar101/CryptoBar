//
//  MenuBarViewModel.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 04.03.2022.
//

import Combine
import Foundation
import SwiftUI

class MenuBarViewModel: ObservableObject {
    @Published var type: CoinType = .ethereum
//    @Published var value: String = "…"
    @Published var value: String = "..."
    @Published var isError: Bool = false
    
    @AppStorage("SelectedCoinType") var selectedCoinType: CoinType = .ethereum

    let service: PriceService
    private var subscriptions = Set<AnyCancellable>()

    init(service: PriceService) {
        self.service = service
    }

    func subscribeToService() {
        service.coinSubject
            .combineLatest(service.connectionSubject)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.updateView() }
            .store(in: &subscriptions)
    }

    func updateView() {
        let coin = service.coin.first { $0.type == selectedCoinType }

        if service.isConnected {
            isError = false
            guard let coin = coin else {
                value = "..."
                return
            }
            type = coin.type
            value = coin.value.format()
        } else {
            isError = true
            value = "Offline"
        }
    }
}
