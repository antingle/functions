//
//  ButtonView.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/16/22.
//

import SwiftUI

struct ButtonView: View {
    @Binding var expression: String
    @Binding var history: [History]
    @Binding var historyIndex: Int
    
    var body: some View {
        HStack {
            Button("C") {
                expression = ""
                historyIndex = -1
            }.calcButton()
            
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
                if (!history.isEmpty && historyIndex < history.count - 1)
                {
                    historyIndex += 1
                    
                    // if incrementing history, remove the number of characters of previous addition
                    if historyIndex > 0 {
                        expression.removeLast(history[historyIndex - 1].solution.count)
                    }
                    expression += history[historyIndex].solution
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
                
                if (!history.isEmpty)
                {
                    // check if UP ARROW has been pressed yet
                    if historyIndex != -1 {
                        // if decrementing history, remove the number of characters of previous addition
                        expression.removeLast(history[historyIndex].solution.count)
                        historyIndex -= 1
                        
                        // if we are not at the beginning of history, add the next solution in
                        if historyIndex != -1 {
                            expression += history[historyIndex].solution
                        }
                    }
                }
            } label: {
                Image(systemName: "arrow.down")
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
    
    func addAnswer() {
        if (!history.isEmpty)
        {
            expression += history[0].solution
        }
    }
}
