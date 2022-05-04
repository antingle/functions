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
    
        // extra symbols, variables, and functions are defined here
    let expression = Expression(givenExpression, symbols: [
        .infix("^"): { params in pow(params[0], params[1]) },           // raising to the power
        .infix("--"): { params in params[0] + params[1] },              // double negative
        
        .variable("e"): { _ in Darwin.M_E },                            // euler's number
        .variable("π"): { _ in .pi },                                   // pi symbol
        
        .function("ln", arity: 1): { params in log(params[0]) },        // natural log
        .function("log", arity: 1): { params in log10(params[0]) },     // log base 10
        .function("log10", arity: 1): { params in log10(params[0]) },   // ALT log base 10
        .function("log2", arity: 1): { params in log2(params[0]) },     // log base 2
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
