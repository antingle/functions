//
//  ContentView.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/14/22.
//

import SwiftUI
import Expression

struct WindowView: View {
    @State private var showingSettings = false
    @EnvironmentObject var historyStore: HistoryStore
    
    var body: some View {
        VStack {
            
            CalculatorView()
                .frame(maxWidth: 600)
            
            // MARK: - Bottom Bar
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
            }
            .padding(.top, 8)
            
        }
        .padding([.horizontal, .bottom])
        .frame(minWidth: 250, minHeight: 265) // constrain min size of window
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
struct WindowView_Previews: PreviewProvider {
    static var previews: some View {
        WindowView()
            .environmentObject(HistoryStore())
            .frame(width: 280, height: 460)
    }
}
