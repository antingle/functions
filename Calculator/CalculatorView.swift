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
        
        MacEditorTextView(text: $expression, placeholderText: "Calculate", isEditable: true, onEditingChanged: {}, onCommit: {do {
            solution = try evaluateExpression(expression)
            
            // insert item into history
            withAnimation(.spring()) {
                let historyItem = History(expression: expression, solution: solution.removeZerosFromEnd())
                history.insert(historyItem, at: 0)
                
            }
            expression = ""
        }
            catch {
                solution = 0
            }}, onTextChange: {newExpression in
                do {
                    solution = try evaluateExpression(newExpression)
                }
                catch {
                    solution = 0
                } })
        //        TextFieldAppKit("Calculate", text: $expression, nsFont: .systemFont(ofSize: 14))
        //            .onCommit {
        //                do {
        //                    solution = try evaluateExpression(expression)
        //
        //                    // insert item into history
        //                    withAnimation(.spring()) {
        //                        let historyItem = History(expression: expression, solution: solution.removeZerosFromEnd())
        //                        history.insert(historyItem, at: 0)
        //
        //                    }
        //                    expression = ""
        //                }
        //                catch {
        //                    solution = 0
        //                }
        //            }
        //            .onChange(of: expression) { newExpression in
        //                do {
        //                    solution = try evaluateExpression(newExpression)
        //                }
        //                catch {
        //                    solution = 0
        //                }
        //            }
        //
        // Expressions are typed in here
        //        TextField("Calculate", text: $expression)
        //            .textFieldStyle(.plain)
        //            .onSubmit {
        //
        //            }
        //
        //            }
        
        
        Text(solution == 0 ? " " : solution.removeZerosFromEnd())
            .font(.caption)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .foregroundColor(.gray)
        
        ButtonView(expression: $expression, history: $history)
    }
}
