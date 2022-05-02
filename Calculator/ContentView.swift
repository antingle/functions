//
//  ContentView.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/14/22.
//

import SwiftUI
import Expression
struct ContentView: View {
    @State private var showingSettings = false
    @StateObject private var store = HistoryStore()
    
    var body: some View {
        VStack {
            
            CalculatorView() 
            
            HStack {
                Text("Menu Bar Calc")
                    .font(.headline)
                
                Spacer()
                
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
                Button {
                    NSApp.sendAction(#selector(AppDelegate.openCalculatorWindow), to: nil, from:nil)
                } label: {
                    Image(systemName: "macwindow")
                }
                .buttonStyle(.plain)
            }
            .padding(.top, 8)
            
        }
        .padding([.horizontal, .bottom])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environmentObject(store)
        .onAppear {
            HistoryStore.load { result in
                switch result {
                case .failure(let error):
                    fatalError(error.localizedDescription)
                case .success(let history):
                    store.history = history
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 300.0)
    }
}
