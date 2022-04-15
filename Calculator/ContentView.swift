//
//  ContentView.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/14/22.
//

import SwiftUI
import MathExpression

struct ContentView: View {
    @Namespace var mainNamespace
    @State private var isUpdated: Bool = false
    @State private var expression: String = ""
    @State private var solution = 0.0
    @State private var history: [History] = []
    @FocusState private var focusedField
    
    var body: some View {
        VStack {
            
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
            
            // Expressions are typed in here
            TextField("Calculate", text: $expression)
                .textFieldStyle(.plain)
                .onSubmit {
                    do {
                        solution = try evaluteExpression(expression)
                        
                        // insert item into history
                        withAnimation(.spring()) {
                        let historyItem = History(expression: expression, solution: solution.removeZerosFromEnd())
                        history.insert(historyItem, at: 0)
                        
                        }
                        expression = ""
                    }
                    catch {
                        solution = 0
                    }
                }
                .onChange(of: expression) { newExpression in
                    do {
                        solution = try evaluteExpression(expression)
                    }
                    catch {
                        solution = 0
                    }
                }
            
            
            Text(solution == 0 ? " " : solution.removeZerosFromEnd())
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.gray)
            
            HStack {
                Button {
                    expression += "+"
                } label: {
                    Image(systemName: "plus")
                }
                Button() {
                    expression += "-"
                } label: {
                    Image(systemName: "minus")
                }
                Button() {
                    expression += "*"
                } label: {
                    Image(systemName: "multiply")
                }
                Button {
                    expression += "/"
                } label: {
                    Image(systemName: "divide")
                }
            }
            
        }
        .padding([.horizontal, .bottom])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 350)
    }
    
    func evaluteExpression(_ expression: String) throws -> Double {
        let expression = try MathExpression(expression)
        return expression.evaluate()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 300.0)
    }
}
