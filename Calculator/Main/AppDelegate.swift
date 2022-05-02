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
    let hotKey = HotKey(key: .c, modifiers: [.command, .option]) // global open shortcut
    var popover = NSPopover.init()
    var statusBarItem: NSStatusItem?
    static var shared : AppDelegate!
    private var historyStore = HistoryStore() // Environment Object for History
    
    var window: NSWindow!

        @objc func openCalculatorWindow() {
            if nil == window {      // create once !!
                window = NSWindow(
                    contentRect: NSRect(x: 20, y: 20, width: 280, height: 460),
                    styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                    backing: .buffered,
                    defer: false)
                // MARK TODO: does this not limit window size?
                // window.contentMinSize = NSSize(width: 200, height: 300)
                window.titlebarAppearsTransparent = true
                window.collectionBehavior = .fullScreenPrimary
                window.title = "Menu Bar Calc"
                window.center()
                window.setFrameAutosaveName("Calculator")
                window.isReleasedWhenClosed = false
                window.contentView = NSHostingView(rootView: ContentView().environmentObject(historyStore))
            }
            window.makeKeyAndOrderFront(nil)
        }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        // close window on launch
        if let window = NSApplication.shared.windows.first {
            window.close()
        }
        
        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        popover.behavior = .transient
        popover.animates = true
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSHostingView(rootView: ContentView().environmentObject(historyStore))
        popover.contentViewController?.view.window?.makeKey()
        popover.contentSize = CGSize(width: 280, height: 460)
        
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem?.button?.image = NSImage(systemSymbolName: "function", accessibilityDescription: "calculator")
        statusBarItem?.button?.action = #selector(AppDelegate.togglePopover(_:))
        
        // enables global shortcut
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
