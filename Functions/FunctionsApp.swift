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

    var body: some Scene {
        MenuBarExtra("Functions", systemImage: "function") {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .frame(width: 280, height: 460)
               
        }
        .menuBarExtraStyle(.window)
        
        WindowGroup("Functions", id: "window") {
            ContentView(isWindow: true)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .frame(minWidth: 240, minHeight: 296)
                .handlesExternalEvents(preferring: Set(arrayLiteral: "window"), allowing: Set(arrayLiteral: "*"))
        }
        .defaultSize(width: 280, height: 460)
        .windowToolbarStyle(.unifiedCompact)
        .handlesExternalEvents(matching: Set(arrayLiteral: "window"))
        
        Settings {
            VStack {
                Text("Hello settings :)")
            }
            .frame(width: 400, height: 300)
        }
    }
}
