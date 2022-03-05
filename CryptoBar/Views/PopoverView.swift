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
            ForEach(Array(vm.coins.enumerated()), id: \.offset) { index, coin in
                HStack(alignment: .center, spacing: 4) {
                    Text(coin.type.ticker)
                        .font(.system(.title2, design: .monospaced))
                        .fontWeight(.black)
                        .foregroundColor(.orange)
                    Text(coin.type.rawValue)
                        .font(.caption)
                        .fontWeight(.bold)
                    Spacer()
                    Link(destination: coin.type.url) {
                        Text(coin.value.format())
                            .font(.system(.title3, design: .monospaced))
                            .fontWeight(.bold)
                        Image(systemName: "arrow.up.right.circle")
                            .font(.title2)
                    }
                    .foregroundColor(.white)
                    .layoutPriority(100)
                }
                if index < vm.coins.count - 1 {
                    Divider()
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
