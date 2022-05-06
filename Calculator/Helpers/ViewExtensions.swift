//
//  ViewExtensions.swift
//  Calculator
//
//  Created by Anthony Ingle on 5/2/22.
//

import SwiftUI

struct CalcButtonStyle: ButtonStyle {
  var foregroundColor: Color
  var backgroundColor: Color
  var pressedColor: Color

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .frame(height: 20)
      .frame(maxWidth: .infinity)
      .foregroundColor(foregroundColor)
      .background(configuration.isPressed ? pressedColor : backgroundColor)
      .cornerRadius(5)
  }
}

extension Button {
  func calcButton(
    foregroundColor: Color = .primary,
    backgroundColor: Color = Color(nsColor: .quaternaryLabelColor),
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

// Used as an invalid submission shake animation
// https://www.objc.io/blog/2019/10/01/swiftui-shake-animation/
struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}
