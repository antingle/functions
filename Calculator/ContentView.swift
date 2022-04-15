//
//  ContentView.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/14/22.
//

import SwiftUI
import MathExpression

struct ContentView: View {
    @State private var isUpdated: Bool = false
    @State private var expression: String = ""
    @State private var solution = 0.0
    @State private var history: [History] = []
    
    var body: some View {
        VStack {
            
            // this is an upside down scroll view to show history
            ScrollView(.vertical, showsIndicators: false, content: {
                LazyVStack(alignment: .center, spacing: nil, content: {
                    
                    // this is reversed order since it is flipped
                    ForEach(history) { item in
                        VStack {
                            Text(item.solution)
                                .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(.title2)
                                .onTapGesture {
                                    expression += item.solution
                                }.padding(.top, 2)
                            Text(item.expression)
                                .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.body)
                                .onTapGesture {
                                    expression += item.expression
                                    
                                }
                        }.padding(.top, 4)
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
                        let historyItem = History(expression: expression, solution: solution.removeZerosFromEnd())
                        history.insert(historyItem, at: 0)
                        expression = ""
                    }
                    catch {
                        solution = 0
                    }
                    
                }
            
        }.padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
