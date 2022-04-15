//
//  HelperFunctions.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/14/22.
//

import Foundation

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
