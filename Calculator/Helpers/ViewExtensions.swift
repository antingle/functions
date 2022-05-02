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
