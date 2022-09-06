//
//  ContentView.swift
//  Functions
//
//  Created by Anthony Ingle on 6/17/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \History.timestamp, ascending: true)],
        animation: .default)
    private var history: FetchedResults<History>
    @State private var showingSettings = false
    @State private var showingInfo = false
    
    var isWindow = false
    @Environment(\.openURL) private var openURL

    var body: some View {
        VStack {
            CalculatorView()
            
            // MARK: - Bottom Bar
            HStack {
                Image(systemName: "function")
                    .foregroundColor(.accentColor)
                Text("Functions")
                    .font(.headline)
                    .foregroundColor(.accentColor)
                
                Spacer()
                
                // Info Button
                Button {
                    showingInfo.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
                .buttonStyle(.plain)
                .popover(isPresented: $showingInfo, content: {
                    InfoView().padding()
                })
                
                // Settings Button
                Button {
                    showingSettings.toggle()
                } label: {
                    Image(systemName: "gearshape")
                }
                .buttonStyle(.plain)
                .popover(isPresented: $showingSettings, content: {
                    SettingsView().padding()
                })
                
                // Open in separate window
                if !isWindow {
                    Button {
                        openURL(URL(string: "Functions://window")!)
                    } label: {
                        Image(systemName: "macwindow")
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.top, 8)
            
        }
        .padding([.horizontal, .bottom])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
           
    }

    private func addItem() {
        withAnimation {
            let newItem = History(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { history[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .frame(width: 280, height: 460)
    }
}
