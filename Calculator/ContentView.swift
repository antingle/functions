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
    @State private var expression: String = ""
    @State private var solution: Double = 0.0
    @State private var history: [History] = []
    
    var body: some View {
        VStack {
            
            if showingSettings {
                SettingsView()
                    .padding(.top)
                Spacer()
            }
            else {
                CalculatorView(expression: $expression, solution: $solution, history: $history)
        }
            
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
            }
                .padding(.top, 8)
            
        }
        .padding([.horizontal, .bottom])
        .frame(width: 260, height: 400)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 300.0)
    }
}
