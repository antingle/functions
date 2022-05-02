//
//  HelperFunctions.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/14/22.
//

import SwiftUI
import Expression

func evaluateExpression(_ givenExpression: String) throws -> Double {
    var solution: Double = 0
    
    // ability to use ^ as a power operator
    let expression = Expression(givenExpression, symbols: [
        .infix("^"): { params in pow(params[0], params[1]) },       // raising to the power
        .infix("--"): { params in params[0] + params[1] },          // double negative
        .variable("e"): { _ in Darwin.M_E },                        // euler's number
        .function("ln", arity: 1): { params in log(params[0]) },    // natural log
        .function("log", arity: 1): { params in log10(params[0]) },    // natural log
    ])
    
    solution = try expression.evaluate()
    
    return solution;
}

extension Double {
    // removes zeros from the end of a Double when converting to String
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 // maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

struct CalcButtonStyle: ButtonStyle {
  var foregroundColor: Color
  var backgroundColor: Color
  var pressedColor: Color

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .frame(height: 20)
      .frame(maxWidth: .infinity)
      .foregroundColor(foregroundColor)
      .background(configuration.isPressed ? .tertiary : .quaternary)
      .cornerRadius(5)
  }
}

extension Button {
  func calcButton(
    foregroundColor: Color = .primary,
    backgroundColor: Color = .secondary,
    pressedColor: Color = .accentColor
  ) -> some View {
    self.buttonStyle(
      CalcButtonStyle(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        pressedColor: pressedColor
      )
    )
  }
}
