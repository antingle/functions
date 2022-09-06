//
//  InfoView.swift
//  Functions
//
//  Created by Anthony Ingle on 5/5/22.
//

import SwiftUI

// View for info and descriptions of functions, operators, and constants
struct InfoView: View {
    var body: some View {
        HStack(alignment: .top) {
            
            Text("""
                        **Welcome to Functions!**
                        - Type expressions to calculate!
                        - Add previous solutions with ↑↓ arrow keys
                        - Feel free to give feedback [here](https://github.com/ingleanthony/functions/issues)
                        
                        **Constants**
                        π or pi
                        e (Euler's)
                        
                        **Operators**
                        **(x + y)** - Addition
                        **(x - y)** - Subtraction
                        **(x * y)** - Multiplication
                        **(x / y)** - Division
                        **(x % y)** - Remainder/Modulo
                        **(x ^ y)** - Power
                        **(x E y** or **x e y)** - Exponent of 10
                        
                        """)
            .padding(.trailing)
            
            Text("""
                    **Functions**
                    **abs(x)** - Absolute Value
                    **sqrt(x)** - Square Root
                    **ln(x)** - Natural Log
                    **log(x)** or **log10(x)** - Log Base 10
                    **log2(x)** - Log Base 2
                    **round(x)** - Round
                    **ceil(x)** - Round Up
                    **floor(x)** - Round Down
                    **pow(x, y)** - Power
                    **mod(x, y)** - Remainder/Modulo
                    **max(x,y,[...])** - Maximum
                    **min(x,y,[...])** - Minimum
                    
                    **Trigonometry**
                    **cos(x)** - Cosine
                    **sin(x)** - Sin
                    **tan(x)** - Tangent
                    **cos(x)** - Inverse Cosine
                    **sin(x)** - Inverse Sin
                    **tan(x)** - Inverse Tangent
                    **atan2(x,y)** - Inverse Tangent of y/x
                    """)
            
            
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
