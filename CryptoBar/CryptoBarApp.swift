//
//  CryptoBarApp.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 19.02.2022.
//

import SwiftUI

@main
struct CryptoBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            EmptyView().frame(width: 0, height: 0)
        }
    }
}
