//
//  ButtonView.swift
//  Functions
//
//  Created by Anthony Ingle on 4/16/22.
//

import SwiftUI

struct ButtonView: View {
    @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \History.timestamp, ascending: false)],
            animation: .default)
        private var history: FetchedResults<History>
    @Binding var expression: String
    @Binding var historyIndex: Int
    @Binding var shouldMoveCursorToEnd: Bool
    @AppStorage("accentColor") private var accentColor = "indigo"
    
    var body: some View {
        VStack {
            
            // MARK: - Row 1
            HStack {
                Button("C") {
                    expression = ""
                    historyIndex = -1
                }.calcButton(backgroundColor: Color(accentColor),
                             pressedColor: Color(nsColor: .tertiaryLabelColor))
                
                Button {
                    addToExpression("+")
                } label: {
                    Image(systemName: "plus")
                }.calcButton()
                
                Button() {
                    addAnswer()
                    addToExpression("-")
                } label: {
                    Image(systemName: "minus")
                }.calcButton()
                
                Button() {
                    addToExpression("*")
                } label: {
                    Image(systemName: "multiply")
                }.calcButton()
                
                Button {
                    addToExpression("/")
                } label: {
                    Image(systemName: "divide")
                }.calcButton()
                
                Button {
                    // MARK TODO: This is redundant code from CalculatorView onMoveUp()
                    // check that history array is not empty and history index does not go out of bounds
                    if (!history.isEmpty && historyIndex < history.count - 1)
                    {
                        shouldMoveCursorToEnd = true
                        historyIndex += 1
                        
                        // if incrementing history, remove the number of characters of previous addition
                        if historyIndex > 0 {
                            expression.removeLast(history[historyIndex - 1].solution!.count)
                        }
                        expression += history[historyIndex].solution!
                    }
                } label: {
                    Image(systemName: "arrow.up")
                }.calcButton()
            }
            
            // MARK: - Row 2
            HStack {
                Button("-") {
                    addToExpression("-")
                }.calcButton()
                
                Button {
                    addToExpression("sqrt(")
                } label: {
                    Image(systemName: "x.squareroot")
                }.calcButton()
                
                Button ("^") {
                    addToExpression("^(")
                }.calcButton()
                
                Button ("(") {
                    addToExpression("(")
                }.calcButton()
                
                Button (")") {
                    addToExpression(")")
                }.calcButton()
                
                Button {
                    // MARK TODO: This is redundant code from CalculatorView onMoveDown()
                    if (!history.isEmpty)
                    {
                        shouldMoveCursorToEnd = true
                        // check if UP ARROW has been pressed yet
                        if historyIndex != -1 {
                            // if decrementing history, remove the number of characters of previous addition
                            expression.removeLast(history[historyIndex].solution!.count)
                            historyIndex -= 1
                            
                            // if we are not at the beginning of history, add the next solution in
                            if historyIndex != -1 {
                                expression += history[historyIndex].solution!
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
                    addAnswer()
                    addToExpression("E")
                }.calcButton()
                
                Button ("π") {
                    addToExpression("π")
                }.calcButton()
                
                Button ("eˣ") {
                    addToExpression("e^(")
                }.calcButton()
                
                Button ("ln(x)") {
                    addToExpression("ln(")
                }.calcButton()
                
                Button ("log(x)") {
                    addToExpression("log(")
                }.calcButton()
            }
            
            // MARK: - Row 4
            HStack {
                Button ("sin(x)") {
                    addToExpression("sin(")
                }.calcButton()
                
                Button ("cos(x)") {
                    addToExpression("cos(")
                }.calcButton()
                
                Button ("tan(x)") {
                    addToExpression("tan(")
                }.calcButton()
            }
            
            // MARK: - Row 5
            HStack {
                Button ("asin(x)") {
                    addToExpression("asin(")
                }.calcButton()
                
                Button ("acos(x)") {
                    addToExpression("acos(")
                }.calcButton()
                
                Button ("atan(x)") {
                    addToExpression("atan(")
                }.calcButton()
            }
        }
        .frame(maxWidth: 600)
    }
    
    // MARK: - Helper Functions
    private func addAnswer() {
        if (!history.isEmpty && expression == "")
        {
            shouldMoveCursorToEnd = true
            expression += history[0].solution!
        }
    }
    
    private func addToExpression(_ string: String) {
        shouldMoveCursorToEnd = true
        expression += string
        historyIndex = -1
    }
}

// MARK: - Preview
//struct Previews_ButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonView(expression: .constant(""), historyIndex: .constant(-1), shouldMoveCursorToEnd: .constant(true))
//            .environmentObject(HistoryStore())
//            .frame(width: 280)
//    }
//}
