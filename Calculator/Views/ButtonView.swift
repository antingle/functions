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
    @Binding var shouldMoveCursorToEnd: Bool
    @EnvironmentObject var historyStore: HistoryStore
    
    var body: some View {
        VStack {
            
            // MARK: - Row 1
            HStack {
                Button("C") {
                    expression = ""
                    historyIndex = -1
                }.calcButton(backgroundColor: Color.accentColor,
                             pressedColor: Color(nsColor: .tertiaryLabelColor))
                
                Button {
                    shouldMoveCursorToEnd = true
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
                    shouldMoveCursorToEnd = true
                    expression += "*"
                    historyIndex = -1
                } label: {
                    Image(systemName: "multiply")
                }.calcButton()
                
                Button {
                    shouldMoveCursorToEnd = true
                    expression += "/"
                    historyIndex = -1
                } label: {
                    Image(systemName: "divide")
                }.calcButton()
                
                Button {
                    // check that history array is not empty and history index does not go out of bounds
                    if (!historyStore.history.isEmpty && historyIndex < historyStore.history.count - 1)
                    {
                        shouldMoveCursorToEnd = true
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
            
            // MARK: - Row 2
            HStack {
                Button("-") {
                    shouldMoveCursorToEnd = true
                    expression += "-"
                    historyIndex = -1
                }.calcButton()
                
                Button {
                    shouldMoveCursorToEnd = true
                    expression += "sqrt("
                    historyIndex = -1
                } label: {
                    Image(systemName: "x.squareroot")
                }.calcButton()
                
                Button ("^") {
                    shouldMoveCursorToEnd = true
                    expression += "^"
                    historyIndex = -1
                }.calcButton()
                
                Button ("(") {
                    shouldMoveCursorToEnd = true
                    expression += "("
                    historyIndex = -1
                }.calcButton()
                
                Button (")") {
                    shouldMoveCursorToEnd = true
                    expression += ")"
                    historyIndex = -1
                }.calcButton()
                
                Button {
                    
                    if (!historyStore.history.isEmpty)
                    {
                        shouldMoveCursorToEnd = true
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
            
            // MARK: - Row 3
            HStack {
                Button ("EE") {
                    shouldMoveCursorToEnd = true
                    expression += "E"
                    historyIndex = -1
                }.calcButton()
                
                Button ("π") {
                    shouldMoveCursorToEnd = true
                    expression += "π"
                    historyIndex = -1
                }.calcButton()
                
                Button ("eˣ") {
                    shouldMoveCursorToEnd = true
                    expression += "e^"
                    historyIndex = -1
                }.calcButton()
                
                Button ("ln(x)") {
                    shouldMoveCursorToEnd = true
                    expression += "ln("
                    historyIndex = -1
                }.calcButton()
                
                Button ("log(x)") {
                    shouldMoveCursorToEnd = true
                    expression += "log("
                    historyIndex = -1
                }.calcButton()
            }
            
            // MARK: - Row 4
            HStack {
                Button ("sin(x)") {
                    shouldMoveCursorToEnd = true
                    expression += "sin("
                    historyIndex = -1
                }.calcButton()
                
                Button ("cos(x)") {
                    shouldMoveCursorToEnd = true
                    expression += "cos("
                    historyIndex = -1
                }.calcButton()
                
                Button ("tan(x)") {
                    shouldMoveCursorToEnd = true
                    expression += "tan("
                    historyIndex = -1
                }.calcButton()
            }
            
            // MARK: - Row 5
            HStack {
                Button ("asin(x)") {
                    shouldMoveCursorToEnd = true
                    expression += "asin("
                    historyIndex = -1
                }.calcButton()
                
                Button ("acos(x)") {
                    shouldMoveCursorToEnd = true
                    expression += "acos("
                    historyIndex = -1
                }.calcButton()
                
                Button ("atan(x)") {
                    shouldMoveCursorToEnd = true
                    expression += "atan("
                    historyIndex = -1
                }.calcButton()
            }
        }
        .frame(maxWidth: 600)
    }
    
    // MARK: - Helper Functions
    private func addAnswer() {
        if (!historyStore.history.isEmpty)
        {
            shouldMoveCursorToEnd = true
            expression += historyStore.history[0].solution
        }
    }
}

// MARK: - Preview
struct Previews_ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(expression: .constant(""), historyIndex: .constant(-1), shouldMoveCursorToEnd: .constant(true))
            .environmentObject(HistoryStore())
            .frame(width: 280)
    }
}
