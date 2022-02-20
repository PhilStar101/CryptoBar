//
//  MenuBarCoinView.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 19.02.2022.
//

import SwiftUI

struct MenuBarCoinView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            VStack(alignment: .trailing, spacing: 2) {
                HStack(alignment: .top, spacing: 0) {
                    Rectangle().opacity(0).frame(width: 2, height: 8)
                    Image(systemName: "circle.fill")
                        .foregroundColor(.green)
                        .font(.system(size: 6))
                        .frame(width: 8, height: 8)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Text("btc".uppercased())
                        .font(.system(size: 12, design: .monospaced))
                        .fontWeight(.black)
                        .frame(height: 10)
                        .foregroundColor(Color(hue: 0.107, saturation: 0.679, brightness: 0.964))
                }
                Text("100000,03")
                    .font(.system(size: 10, design: .monospaced))
                    .fontWeight(.bold)
                    .frame(height: 8)
            }
            .frame(height: 20)
            .clipped()
        }
//        .padding(.horizontal, 4)
    }
}

struct MenuBarCoinView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarCoinView().frame(width: 60, height: 24)
    }
}
