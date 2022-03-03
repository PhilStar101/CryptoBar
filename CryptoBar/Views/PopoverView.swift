//
//  PopoverView.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 03.03.2022.
//

import SwiftUI

struct PopoverView: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                Text("BTC")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                Text("Bitcoin")
                    .font(.caption)
                    .fontWeight(.bold)
                Spacer()
                Text("100000,03")
                    .font(.system(.title3, design: .monospaced))
                    .fontWeight(.bold)
            }
            Divider()
            HStack(alignment: .firstTextBaseline) {
                Text("ETH")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                Text("Ethereum")
                    .font(.caption)
                    .fontWeight(.bold)
                Spacer()
                Text("100000,03")
                    .font(.system(.title3, design: .monospaced))
                    .fontWeight(.bold)
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical)
    }
}

struct PopoverView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverView().frame(width: 248, height: 264)
    }
}
