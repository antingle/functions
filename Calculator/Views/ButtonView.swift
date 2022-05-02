//
//  ButtonView.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/16/22.
//

import SwiftUI

struct ButtonView: View {
    @Binding var expression: String
    @Binding var historyIndex: Int
    @EnvironmentObject var historyStore: HistoryStore
    
    var body: some View {
        VStack {
            HStack {
                Button("C") {
                    expression = ""
                    historyIndex = -1
                }.calcButton(backgroundColor: Color.accentColor,
                             pressedColor: Color(nsColor: .tertiaryLabelColor))
                
                Button {
                    expression += "+"
                    historyIndex = -1
                } label: {
                    Image(systemName: "plus")
                }.calcButton()
                
                Button() {
                    expression == "" ? addAnswer() : nil
                    expression += "-"
                    historyIndex = -1
                } label: {
                    Image(systemName: "minus")
                }.calcButton()
                
                Button() {
                    expression += "*"
                    historyIndex = -1
                } label: {
                    Image(systemName: "multiply")
                }.calcButton()
                
                Button {
                    expression += "/"
                    historyIndex = -1
                } label: {
                    Image(systemName: "divide")
                }.calcButton()
                
                Button {
                    // check that history array is not empty and history index does not go out of bounds
                    if (!historyStore.history.isEmpty && historyIndex < historyStore.history.count - 1)
                    {
                        historyIndex += 1
                        
                        // if incrementing history, remove the number of characters of previous addition
                        if historyIndex > 0 {
                            expression.removeLast(historyStore.history[historyIndex - 1].solution.count)
                        }
                        expression += historyStore.history[historyIndex].solution
                    }
                } label: {
                    Image(systemName: "arrow.up")
                }.calcButton()
            }
            
            HStack {
                Button("-") {
                    expression += "-"
                    historyIndex = -1
                }.calcButton()
                
                Button {
                    expression += "sqrt("
                    historyIndex = -1
                } label: {
                    Image(systemName: "x.squareroot")
                }.calcButton()
                
                Button ("^") {
                    expression += "^"
                    historyIndex = -1
                }.calcButton()
                
                Button ("(") {
                    expression += "("
                    historyIndex = -1
                }.calcButton()
                
                Button (")") {
                    expression += ")"
                    historyIndex = -1
                }.calcButton()
                
                Button {
                    
                    if (!historyStore.history.isEmpty)
                    {
                        // check if UP ARROW has been pressed yet
                        if historyIndex != -1 {
                            // if decrementing history, remove the number of characters of previous addition
                            expression.removeLast(historyStore.history[historyIndex].solution.count)
                            historyIndex -= 1
                            
                            // if we are not at the beginning of history, add the next solution in
                            if historyIndex != -1 {
                                expression += historyStore.history[historyIndex].solution
                            }
                        }
                    }
                } label: {
                    Image(systemName: "arrow.down")
                }.calcButton()
            }
            
            HStack {
                Button ("EE") {
                    expression += "E"
                    historyIndex = -1
                }.calcButton()
                
                Button ("π") {
                    expression += "π"
                    historyIndex = -1
                }.calcButton()
                
                Button ("eˣ") {
                    expression += "e^"
                    historyIndex = -1
                }.calcButton()
                
                Button ("ln(x)") {
                    expression += "ln("
                    historyIndex = -1
                }.calcButton()
                
                Button ("log(x)") {
                    expression += "log("
                    historyIndex = -1
                }.calcButton()
            }
            
            HStack {
                Button ("sin(x)") {
                    expression += "sin("
                    historyIndex = -1
                }.calcButton()
                
                Button ("cos(x)") {
                    expression += "cos("
                    historyIndex = -1
                }.calcButton()
                
                Button ("tan(x)") {
                    expression += "tan("
                    historyIndex = -1
                }.calcButton()
            }
            
            HStack {
                Button ("asin(x)") {
                    expression += "asin("
                    historyIndex = -1
                }.calcButton()
                
                Button ("acos(x)") {
                    expression += "acos("
                    historyIndex = -1
                }.calcButton()
                
                Button ("atan(x)") {
                    expression += "atan("
                    historyIndex = -1
                }.calcButton()
            }
        }
        .frame(maxWidth: 600)
    }
    
    private func addAnswer() {
        if (!historyStore.history.isEmpty)
        {
            expression += historyStore.history[0].solution
        }
    }
}

struct Previews_ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(expression: .constant(""), historyIndex: .constant(-1))
            .environmentObject(HistoryStore())
            .frame(width: 280)
    }
}
