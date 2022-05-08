//
//  HistoryView.swift
//  Calculator
//
//  Created by Anthony Ingle on 5/1/22.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var historyStore: HistoryStore
    @Binding var expression: String
    @Binding var historyIndex: Int
    @Binding var shouldMoveCursorToEnd: Bool
    
    var body: some View {
        // MARK TODO: Make this file more readable
        // this is an upside down scroll view to show history of expressions and solutions
        ScrollView(.vertical, showsIndicators: false, content: {
            ScrollViewReader { value in
                LazyVStack(alignment: .center) {
                    
                    // MARK: - Each Row
                    ForEach(historyStore.history) { item in
                        VStack {
                            
                            // MARK: - Solution (on the right)
                            HStack {
                                // this is reversed order since it is a ScrollView flipped upside down
                                Text(item.solution)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .font(.title2)
                                    .onTapGesture {
                                        shouldMoveCursorToEnd = true
                                        expression += item.solution
                                    }
                                    .foregroundColor(historyIndex != -1 ? (item.id == historyStore.history[historyIndex].id ? .accentColor : .primary) : .primary)
                                    .id(item.id)
                                
                                // copy solution button
                                Button {
                                    let pasteBoard = NSPasteboard.general
                                    pasteBoard.clearContents()
                                    pasteBoard.writeObjects([item.solution as NSString])
                                } label: {
                                    Image(systemName: "doc.on.doc").foregroundColor(.secondary)
                                }.buttonStyle(.plain)
                                
                            }
                            .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                            .padding(.top, 2)
                            
                            // MARK: - Expression (on the left)
                            Text(item.expression)
                                .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.body)
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    shouldMoveCursorToEnd = true
                                    expression += item.expression
                                }
                            // MARK TODO: Make this an option?
//                                .padding(.bottom, 2)
//                                .overlay(Rectangle().frame(width: nil, height: 0.4, alignment: .bottom).foregroundColor(Color.gray), alignment: .bottom)
                            
                        }
                        .padding(.bottom, 4)
                        .onChange(of: historyIndex) { newIndex in
                            withAnimation {
                                if newIndex != -1 {
                                    value.scrollTo(historyStore.history[newIndex].id)
                                }
                                else if !historyStore.history.isEmpty
                                {
                                    value.scrollTo(historyStore.history[0].id)
                                }
                            }
                        }
                    }
                    // MARK: - End of Each Row
                    
                }
            }
        }).rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
    }
}
