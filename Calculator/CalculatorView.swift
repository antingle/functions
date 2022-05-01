//
//  CalculatorView.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/16/22.
//

import SwiftUI

struct CalculatorView: View {
    @Binding var expression: String
    @Binding var solution: Double
    @Binding var history: [History]
    
    @State private var historyIndex: Int = -1
    
    var body: some View {
        
        // this is an upside down scroll view to show history
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVStack(alignment: .center, spacing: nil, content: {
                
                // this is reversed order since it is flipped
                ForEach(history) { item in
                    VStack {
                        HStack {
                            Text(item.solution)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(.title2)
                                .onTapGesture {
                                    expression += item.solution
                                }
                                .foregroundColor(historyIndex != -1 ? (item.id == history[historyIndex].id ? .blue : .white) : .white)
                            
                            // copy solution button
                            Button {
                                let pasteBoard = NSPasteboard.general
                                pasteBoard.clearContents()
                                pasteBoard.writeObjects([item.solution as NSString])
                            } label: {
                                Image(systemName: "doc.on.doc").foregroundColor(.gray)
                            }.buttonStyle(.plain)
                            
                        }
                        .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                        .padding(.top, 2)
                        Text(item.expression)
                            .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.body)
                            .foregroundColor(.gray)
                            .onTapGesture {
                                expression += item.expression
                                
                            }
                    }
                    .padding(.bottom, 4)
                }
                
            })
        }).rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
        
        
        CustomMacTextView(placeholderText: "Calculate", text: $expression,
                          // on ENTER key press
                          onSubmit: {
            do {
                historyIndex = -1
                solution = try evaluateExpression(expression)
                
                // insert item into history
                withAnimation(.spring()) {
                    let historyItem = History(expression: expression, solution: solution.removeZerosFromEnd())
                    history.insert(historyItem, at: 0)
                    
                }
                expression = ""
                solution = 0
            }
            catch {
                solution = 0
            }
        },
                          // On every update of the text by keyboard
                          onTextChange: { newExpression in
            if !history.isEmpty &&
                (newExpression == "+" ||
                 newExpression == "*" ||
                 newExpression == "/" ||
                 newExpression == "^" ||
                 newExpression == "%")
            {
                expression.insert(contentsOf: history[0].solution, at: expression.startIndex)
            }
            do {
                historyIndex = -1 // reset the history index counter for arrow keys
                solution = try evaluateExpression(newExpression)
            }
            catch {
                solution = 0
            }
        },
                          // on UP ARROW key
                          onMoveUp: {
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
        },
                          // on DOWN ARROW key
                          onMoveDown: {
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
        })
        .frame(height: 27) // MARK TODO: Make height-adjustable
        
        Text(solution == 0 ? " " : solution.removeZerosFromEnd())
            .font(.caption)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .foregroundColor(.gray)
        
        ButtonView(expression: $expression, history: $history, historyIndex: $historyIndex)
    }
}
