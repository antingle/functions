//
//  AppDelegate.swift
//  Functions
//
//  Created by Anthony Ingle on 9/5/22.
//

import SwiftUI

// Using AppDelegate because it is needed for NSPopover
class AppDelegate: NSObject, NSApplicationDelegate {
    static var shared : AppDelegate!
//    private var popover = NSPopover.init()
//    private var statusBarItem: NSStatusItem?
//    private var window: NSWindow!
//
//    @objc func openCalculatorWindow() {
//        if nil == window {      // create once !!
//            let contentView = ContentView(isWindow: true)
//                .environmentObject(historyStore)
//
//            window = NSWindow(
//                contentRect: NSRect(x: 0, y: 0, width: 280, height: 460),
//                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
//                backing: .buffered,
//                defer: false)
//            window.isOpaque = false
//            window.titlebarAppearsTransparent = true
//            window.collectionBehavior = .fullScreenPrimary
//            window.title = "Functions"
//            window.titleVisibility = .hidden // looks better without a title?
//            window.center()
//            window.setFrameAutosaveName("Calculator")
//            window.isReleasedWhenClosed = false
//            window.contentView = NSHostingView(rootView: contentView)
//        }
//        window.makeKeyAndOrderFront(nil)
//        window.orderFrontRegardless()
//    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        // close window on launch
        if let window = NSApplication.shared.windows.first {
            window.close()
        }
        
//        let contentView = PopoverView()
//            .environmentObject(historyStore)
//
//        // Set the SwiftUI's ContentView to the Popover's ContentViewController
//        popover.behavior = .transient
//        popover.animates = true
//        popover.contentViewController = NSViewController()
//        popover.contentViewController?.view = NSHostingView(rootView: contentView)
//        popover.contentViewController?.view.window?.makeKey()
//        popover.contentSize = CGSize(width: 280, height: 460)
//
//        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
//        statusBarItem?.button?.image = NSImage(systemSymbolName: "function", accessibilityDescription: "calculator")
//        statusBarItem?.button?.action = #selector(AppDelegate.togglePopover(_:))
//    }
//
//    @objc func showPopover(_ sender: AnyObject?) {
//        if let button = statusBarItem?.button {
//            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
//            // !!! - displays the popover window with an offset in x in macOS BigSur.
//        }
//    }
//
//    @objc func closePopover(_ sender: AnyObject?) {
//        popover.performClose(sender)
//    }
//
//    @objc func togglePopover(_ sender: AnyObject?) {
//        if popover.isShown {
//            closePopover(sender)
//        } else {
//            showPopover(sender)
//        }
    }
}
