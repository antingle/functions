//
//  AppDelegate.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/14/22.
//

import SwiftUI
import HotKey

// Using AppDelegate because it is needed for NSPopover
class AppDelegate: NSObject, NSApplicationDelegate {
    let hotKey = HotKey(key: .c, modifiers: [.command, .option])
    var popover = NSPopover.init()
    var statusBarItem: NSStatusItem?
    static var shared : AppDelegate!
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        // close window on launch
        if let window = NSApplication.shared.windows.first {
            window.close()
        }
        
        let contentView = ContentView()
        
        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        popover.behavior = .transient
        popover.animates = false
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSHostingView(rootView: contentView)
        popover.contentViewController?.view.window?.makeKey()
        popover.contentSize = CGSize(width: 260, height: 400)
        
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem?.button?.image = NSImage(systemSymbolName: "function", accessibilityDescription: "calculator")
        statusBarItem?.button?.action = #selector(AppDelegate.togglePopover(_:))
        
        hotKey.keyDownHandler = {
            self.togglePopover(self)
        }
        
    }
    @objc func showPopover(_ sender: AnyObject?) {
        if let button = statusBarItem?.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            // !!! - displays the popover window with an offset in x in macOS BigSur.
        }
    }
    @objc func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
    }
    @objc func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
}
