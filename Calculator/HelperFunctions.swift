//
//  HelperFunctions.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/14/22.
//

import Foundation
import Expression

struct History: Identifiable {
    let id = UUID()
    var expression: String
    var solution: String
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 // maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

func evaluateExpression(_ givenExpression: String) throws -> Double {
    var solution: Double = 0;
    
    // ability to use ^ as a power operator
    let expression = Expression(givenExpression, symbols: [
        .infix("^"): { params in pow(params[0], params[1]) },
    ])
    solution = try expression.evaluate()
    
    return solution;
}
