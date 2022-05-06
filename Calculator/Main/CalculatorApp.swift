//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/14/22.
//

import SwiftUI
import KeyboardShortcuts

@main
struct CalculatorApp: App {
    // TODO: This Environment object is different than what is created in the AppDelegate
    // but this object is never used because the window is closed right away in AppDelegate
    @StateObject private var historyStore = HistoryStore()
    @StateObject private var appState = AppState()
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        AppDelegate.shared = self.appDelegate
    }
    /* followed the solution in https://stackoverflow.com/a/65789202/827681 */
    
    var body: some Scene {
        WindowGroup {
            // as of right now, this window is removed on launch
            PopoverView()
                .environmentObject(historyStore)
        }
    }
}

// Allows toggling of the global shortcut
// NOTE: In the KeyboardShortcut docs, this class was @MainActor, but do we need it? (causes warnings)
// @MainActor
final class AppState: ObservableObject {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        KeyboardShortcuts.onKeyDown(for: .togglePopover) { [self] in
            appDelegate.togglePopover(AppDelegate.self)
        }
    }
}
