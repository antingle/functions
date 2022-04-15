//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/14/22.
//

import SwiftUI

@main
struct CalculatorApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
      AppDelegate.shared = self.appDelegate
    }
    /* followed the solution in https://stackoverflow.com/a/65789202/827681 */
    
    var body: some Scene {
        Settings{
            EmptyView()
        }
    }
}

