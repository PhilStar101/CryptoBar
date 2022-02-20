//
//  AppDelegate.swift
//  CryptoBar
//
//  Created by Philipp Starchenko on 19.02.2022.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupMenuBar()
    }

    // MARK: - MENU BAR

    func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: 60)
        guard let menuButton = statusItem?.button else { return }

        let hostingView = NSHostingView(rootView: MenuBarCoinView())

        hostingView.translatesAutoresizingMaskIntoConstraints = false
        menuButton.addSubview(hostingView)
        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: menuButton.topAnchor),
            hostingView.rightAnchor.constraint(equalTo: menuButton.rightAnchor),
            hostingView.bottomAnchor.constraint(equalTo: menuButton.bottomAnchor),
            hostingView.leftAnchor.constraint(equalTo: menuButton.leftAnchor)
        ])
    }
}
