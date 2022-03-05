//
//  MenuBarCoinView.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 19.02.2022.
//

import SwiftUI

struct MenuBarView: View {
    @ObservedObject var vm: MenuBarViewModel

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            VStack(alignment: .trailing, spacing: 2) {
                HStack(spacing: 0) {
                    Spacer()
                }
                Text(vm.type.ticker)
                    .font(.system(size: 12, design: .monospaced))
                    .fontWeight(.black)
                    .frame(height: 8)
                    .foregroundColor(vm.color)
                Text(vm.value)
                    .font(.system(size: 10, design: .monospaced))
                    .fontWeight(.bold)
                    .frame(height: 8)
            }
            .frame(height: 24)
            .clipped()
        }
        .onAppear {
            vm.subscribeToService()
        }
    }
}

struct MenuBarCoinView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarView(vm: .init(service: .init())).frame(width: 60, height: 24)
    }
}
