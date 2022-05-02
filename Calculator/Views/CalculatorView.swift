//
//  CalculatorView.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/16/22.
//

import SwiftUI

struct CalculatorView: View {
    @EnvironmentObject var historyStore: HistoryStore
    @State private var expression: String = ""
    @State private var solution: Double = 0.0
    @State private var historyIndex: Int = -1           // keeps track of place in history when cycling
    @State private var expressionIsValid: Bool = false  // used to show live solution
    
    var body: some View {
        
        VStack {
            // A view to show all previous solutions and expressions
            HistoryView(expression: $expression, historyIndex: $historyIndex)
            
            // An NSTextField wrapped as a SwiftUI view
            CustomMacTextView(placeholderText: "Calculate", text: $expression,
                              // on ENTER key press
                              onSubmit: {
                do {
                    historyIndex = -1
                    solution = try evaluateExpression(expression)
                    
                    // insert item into history
                    withAnimation(.spring()) {
                        let historyItem = History(expression: expression, solution: solution.removeZerosFromEnd())
                        historyStore.history.insert(historyItem, at: 0)
                    }
                    expression = ""
                    solution = 0
                    
                    // save history
                    HistoryStore.save(history: historyStore.history) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
                catch {
                    solution = 0
                }
                
            },
                              // On every update of the textfield by keyboard
                              onTextChange: { newExpression in
                historyIndex = -1 // reset history counter when keyboard used
            },
                              // on UP ARROW key
                              onMoveUp: {
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
            },
                              // on DOWN ARROW key
                              onMoveDown: {
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
            })
            .frame(height: 27) // MARK TODO: Make height-adjustable
            
            // will always run on change of expression variable
            .onChange(of: expression, perform: { newExpression in
                
                // insert previous solution if these operators used first
                if !historyStore.history.isEmpty &&
                    (newExpression == "+" ||
                     newExpression == "*" ||
                     newExpression == "/" ||
                     newExpression == "^" ||
                     newExpression == "%")
                {
                    expression.insert(contentsOf: historyStore.history[0].solution, at: expression.startIndex)
                }
                
                do {
                    solution = try evaluateExpression(newExpression)
                    expressionIsValid = true
                }
                catch {
                    print(error)
                    expressionIsValid = false
                    solution = 0
                }
            })
            
            // Live solution shower
            Text(expressionIsValid ? solution.removeZerosFromEnd() : " ")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.secondary)
            
            // A view for all the buttons at the bottom
            ButtonView(expression: $expression, historyIndex: $historyIndex)
        }
    }
}
