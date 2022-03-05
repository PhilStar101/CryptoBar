//
//  PopoverView.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 03.03.2022.
//

import SwiftUI

struct PopoverView: View {
    @State var show = false
    @ObservedObject var vm: MenuBarViewModel

    var body: some View {
        VStack(spacing: 8) {
            ForEach(vm.coinTypes) { coinType in
                let coin = vm.coins[coinType]
                if let coin = coin {
                    HStack(alignment: .center, spacing: 4) {
                        Text(coinType.ticker)
                            .font(.system(.title2, design: .monospaced))
                            .fontWeight(.black)
                            .foregroundColor(coin.color)
                        Text(coinType.rawValue)
                            .font(.caption)
                            .fontWeight(.bold)
                        Spacer()
                        Link(destination: coin.url) {
                            Text(coin.value.format())
                                .font(.system(.title3, design: .monospaced))
                                .fontWeight(.bold)
                            Image(systemName: "arrow.up.right.circle")
                                .font(.title2)
                        }
                        .foregroundColor(.white)
                        .layoutPriority(100)
                    }
                    if coinType != vm.coinTypes.last {
                        Divider()
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical)
    }
}

struct PopoverView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverView(vm: .init(service: .init()))
            .frame(width: 248, height: 98)
    }
}
