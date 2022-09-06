//
//  HistoryView.swift
//  Functions
//
//  Created by Anthony Ingle on 5/1/22.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \History.timestamp, ascending: false)],
            animation: .default)
        private var history: FetchedResults<History>
    @Binding var expression: String
    @Binding var historyIndex: Int
    @Binding var shouldMoveCursorToEnd: Bool
    @State private var showButtons = false
    
    var body: some View {
        // MARK TODO: Make this file more readable
        // this is an upside down scroll view to show history of expressions and solutions
        ScrollView(.vertical, showsIndicators: false, content: {
            ScrollViewReader { value in
                LazyVStack(alignment: .center) {
                    
                    // MARK: - Each Row
                    ForEach(history) { item in
                        HistoryItemView(item: item, expression: $expression, historyIndex: $historyIndex, shouldMoveCursorToEnd: $shouldMoveCursorToEnd, value: value)
                    }
                }
            }
        }).rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
    }
}
