//
//  FunctionsApp.swift
//  Functions
//
//  Created by Anthony Ingle on 6/17/22.
//

import SwiftUI
import KeyboardShortcuts

@main
struct FunctionsApp: App {
    let persistenceController = PersistenceController.shared
//    @StateObject private var appState = AppState()
    @AppStorage("accentColor") private var accentColor: String = "indigo"
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
        AppDelegate.shared = self.appDelegate
    }
    /* followed the solution in https://stackoverflow.com/a/65789202/827681 */

    var body: some Scene {
        
        MenuBarExtra("Functions", systemImage: "function") {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .frame(width: 280, height: 460)
                .accentColor(Color(accentColor))
        }
        .menuBarExtraStyle(.window)
        
        WindowGroup("Functions", id: "window") {
            ContentView(isWindow: true)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .frame(minWidth: 240, minHeight: 296)
                .handlesExternalEvents(preferring: Set(arrayLiteral: "window"), allowing: Set(arrayLiteral: "*"))
                .accentColor(Color(accentColor))
        }
        .defaultSize(width: 280, height: 460)
        .windowToolbarStyle(.unifiedCompact)
        
//        Settings {
//            VStack {
//                Text("Hello settings :)")
//            }
//            .frame(width: 400, height: 300)
//        }
    }
}

// shortcut removed for now
//@MainActor
//final class AppState: ObservableObject {
//    init() {
//        KeyboardShortcuts.onKeyUp(for: .toggleMenu) {
//            print(NSStatusBar.system)
//        }
//    }
//}
