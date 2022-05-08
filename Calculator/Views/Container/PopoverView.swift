//
//  ContentView.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/14/22.
//

import SwiftUI
import Expression

struct PopoverView: View {
    @EnvironmentObject private var historyStore: HistoryStore
    @State private var showingSettings = false
    @State private var showingInfo = false
    
    var body: some View {
        VStack {
            
            CalculatorView()
            
            // MARK: - Bottom Bar
            HStack {
                Text("Menu Bar Calc")
                    .font(.headline)
                
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
        .onAppear {
            // Load history on from save on launch
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

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverView()
            .environmentObject(HistoryStore())
            .frame(width: 280, height: 460)
    }
}
