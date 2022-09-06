//
//  HelperFunctions.swift
//  Functions
//
//  Created by Anthony Ingle on 4/14/22.
//

import SwiftUI
import Expression
import KeyboardShortcuts

func evaluateExpression(_ givenExpression: String) throws -> Double {
    var solution: Double = 0
    
    // extra symbols, variables, and functions are defined here
    var symbols: [Expression.Symbol : Expression.SymbolEvaluator] = [
        .infix("^"): { params in pow(params[0], params[1]) },           // raising to the power
        .infix("--"): { params in params[0] + params[1] },              // double negative
        
            .variable("e"): { _ in Darwin.M_E },                            // euler's number
        .variable("π"): { _ in .pi },                                   // pi symbol
        
            .function("ln", arity: 1): { params in log(params[0]) },        // natural log
        .function("log", arity: 1): { params in log10(params[0]) },     // log base 10
        .function("log10", arity: 1): { params in log10(params[0]) },   // ALT log base 10
        .function("log2", arity: 1): { params in log2(params[0]) },     // log base 2
    ]
    
    // replaces the trig functions if mode is in degrees
    if let mode = UserDefaults.standard.string(forKey: "trigMode") {
        if mode == "degree" {
            symbols[.function("sin", arity: 1)] = { params in sin(degrees: params[0]) }
            symbols[.function("cos", arity: 1)] = { params in cos(degrees: params[0]) }
            symbols[.function("tan", arity: 1)] = { params in tan(degrees: params[0]) }
            symbols[.function("asin", arity: 1)] = { params in asind(params[0]) }
            symbols[.function("acos", arity: 1)] = { params in acosd(params[0]) }
            symbols[.function("atan", arity: 1)] = { params in atand(params[0]) }
            symbols[.function("atan2", arity: 2)] = { params in atan2d(params[0], params[1]) }
        }
    }
    
    let expression = Expression(givenExpression, symbols: symbols)
    solution = try expression.evaluate()
    
    return solution;
}

// (a)sin, (a)cos, (a)tan in degrees instead of redians
func sin(degrees: Double) -> Double {
    return asin(degrees)
}

func cos(degrees: Double) -> Double {
    return __cospi(degrees/180.0)
}

func tan(degrees: Double) -> Double {
    return __tanpi(degrees/180.0)
}

func asind(_ ratio: Double) -> Double {
    return asin(ratio) * (180 / .pi)
}

func acosd(_ ratio: Double) -> Double {
    return acos(ratio) * (180 / .pi)
}

func atand(_ ratio: Double) -> Double {
    return atan(ratio) * (180 / .pi)
}

func atan2d(_ x: Double, _ y: Double) -> Double {
    return atan2(x, y) * (180 / .pi)
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

// global shortcut
extension KeyboardShortcuts.Name {
    // TODO: maybe not set default? Show welcome screen with option to set it?
    static let toggleMenu = Self("toggleMenu", default: .init(.c, modifiers: [.command, .option]))
}

// This error is used when an expression evaluates to NaN TODO: (could be better)
enum NumberError: Error, CustomStringConvertible {
    case invalid
    public var description: String {
        switch self {
        case .invalid:
            return "Expression does not evaluate to a valid number"
        }
    }
}
