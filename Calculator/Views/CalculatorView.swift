//
//  CalculatorView.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/16/22.
//

import SwiftUI

struct CalculatorView: View {
    @EnvironmentObject var historyStore: HistoryStore   // history of previous calculations
    @State private var expression: String = ""          // expression being typed
    @State private var solution: Double = 0.0           // solution after expression evalutation
    @State private var historyIndex: Int = -1           // keeps track of place in history when cycling
    @State private var expressionIsValid: Bool = false  // used to show live solution
    
    var body: some View {
        
        VStack {
            // MARK: - History View
            // A view to show all previous solutions and expressions
            HistoryView(expression: $expression, historyIndex: $historyIndex)
            
            // MARK: - TextField View
            // An NSTextField wrapped as a SwiftUI view
            CustomMacTextView(placeholderText: "Calculate", text: $expression,
                              onSubmit: onExpressionSubmit, // on ENTER key press
                              // On every update of the textfield by keyboard
                              // reset history counter when keyboard used
                              onTextChange: { _ in historyIndex = -1 },
                              onMoveUp: onMoveCursorUp,  // on UP ARROW key
                              onMoveDown: onMoveCursorDown) // on DOWN ARROW key
            
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
                    expressionIsValid = false
                    solution = 0
                }
            })
            
            // MARK: - Live Solution View
            Text(expressionIsValid ? solution.removeZerosFromEnd() : " ")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.secondary)
            
            // MARK: - Button View
            // A view for all the buttons at the bottom
            ButtonView(expression: $expression, historyIndex: $historyIndex)
        }
    }
    
    // MARK: - Textfield Functions
    fileprivate func onExpressionSubmit() {
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
            // recursively run submit if simply missing parentheses
            if ("\(error)" == "Missing `)`")
            {
                expression += ")"
                onExpressionSubmit()
            }
            else if ("\(error)" == "Missing `(`")
            {
                expression += "("
                onExpressionSubmit()
            }
            solution = 0
        }
    }
    
    fileprivate func onMoveCursorUp() {
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
    }
    
    fileprivate func onMoveCursorDown() {
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
    }
}

// MARK: - Preview
struct Previews_CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .environmentObject(HistoryStore())
            .frame(width: 280)
    }
}
