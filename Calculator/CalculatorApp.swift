//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/14/22.
//

import SwiftUI

@main
struct CalculatorApp: App {
    // MARK TODO: This Environment object is different than what is created in the AppDelegate
    // however, the first window in WindowGroup is closed right away. Hacky solution...
    @StateObject private var historyStore = HistoryStore()
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
        AppDelegate.shared = self.appDelegate
    }
    /* followed the solution in https://stackoverflow.com/a/65789202/827681 */
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(historyStore)
                .onAppear {
                    HistoryStore.load { result in
                        switch result {
                        case .failure(let error):
                            fatalError(error.localizedDescription)
                        case .success(let history):
                            historyStore.history = history
                        }
                    }
                }
        }
    }
}
