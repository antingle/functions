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
    
    var body: some View {
        HStack {
            Button("C") {
                expression = ""
            }.calcButton()
                
            Button {
                expression += "+"
            } label: {
                Image(systemName: "plus")
            }.calcButton()
            
            Button() {
                expression += "-"
            } label: {
                Image(systemName: "minus")
            }.calcButton()
            
            Button() {
                expression += "*"
            } label: {
                Image(systemName: "multiply")
            }.calcButton()
            
            Button {
                expression += "/"
            } label: {
                Image(systemName: "divide")
            }.calcButton()
            
            Button ("Ans") {
                if (!history.isEmpty)
                {
                    expression += history[0].solution
                }
            }.calcButton().frame(width: 40)
        }
        
        HStack {
            Button {
                expression += "sqrt("
            } label: {
                Image(systemName: "x.squareroot")
            }.calcButton()
            Button ("^") {
                expression += "^"
            }.calcButton()
            Button ("%") {
                expression += "%"
            }.calcButton()
            Button ("(") {
                expression += "("
            }.calcButton()
            Button (")") {
                expression += ")"
            }.calcButton()
        }
        
            HStack {
                Button ("sin(x)") {
                    expression += "sin("
                }.calcButton()
                Button ("cos(x)") {
                    expression += "cos("
                }.calcButton()
                Button ("tan(x)") {
                    expression += "tan("
                }.calcButton()
            }

            HStack {
                Button ("asin(x)") {
                    expression += "asin("
                }.calcButton()
                Button ("acos(x)") {
                    expression += "acos("
                }.calcButton()
                Button ("atan(x)") {
                    expression += "atan("
                }.calcButton()
            }
    }
}
