//
//  PopoverView.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 03.03.2022.
//

import SwiftUI

struct PopoverView: View {
    @State var show = false

    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .center, spacing: 4) {
                Text("BTC")
                    .font(.system(.title2, design: .monospaced))
                    .fontWeight(.black)
                    .foregroundColor(.orange)
                Text("Bitcoin")
                    .font(.caption)
                    .fontWeight(.bold)
                Spacer()
                Link(destination: URL(string: "https://google.com")!) {
                    Text("100000,03")
                        .font(.system(.title3, design: .monospaced))
                        .fontWeight(.bold)
                    Image(systemName: "arrow.up.right.circle")
                        .font(.title2)
                }
                .foregroundColor(.white)
            }
            Divider()
            HStack(alignment: .center, spacing: 4) {
                Text("ETH")
                    .font(.system(.title2, design: .monospaced))
                    .fontWeight(.black)
                    .foregroundColor(.purple)
                Text("Ethereum")
                    .font(.caption)
                    .fontWeight(.bold)
                Spacer()
                Link(destination: URL(string: "https://google.com")!) {
                    Text("100000,03")
                        .font(.system(.title3, design: .monospaced))
                        .fontWeight(.bold)
                    Image(systemName: "arrow.up.right.circle")
                        .font(.title3)
                }
                .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical)
    }
}

struct PopoverView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverView()
            .frame(width: 248, height: 98)
    }
}
