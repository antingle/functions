//
//  SettingsView.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/16/22.
//

import SwiftUI
import AudioToolbox

struct SettingsView: View {
    @EnvironmentObject private var historyStore: HistoryStore
    @AppStorage("showingButtons") private var showingButtons = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            
            // MARK: - Toggle Buttons
                Toggle(isOn: $showingButtons, label: {
                    Text("Show Buttons").padding(.leading, 4)
                })
            
            // MARK: - Clear History
            Button {
                withAnimation(.easeOut(duration: 0.1)) {
                    historyStore.history = []
                    HistoryStore.save(history: historyStore.history) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                        AudioServicesPlaySystemSound(0xf) // plays dock item poof sound
                    }
                }
            } label: {
                Image(systemName: "trash")
                Text("Clear History")
            }
            .buttonStyle(.plain)
            
            // MARK: - Quit
            Button {
                NSApplication.shared.terminate(nil)
            } label: {
                Image(systemName: "clear")
                Text("Quit")
            }
            .buttonStyle(.plain)
            .foregroundColor(.red)
        }
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
