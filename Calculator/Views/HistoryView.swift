//
//  HistoryView.swift
//  Calculator
//
//  Created by Anthony Ingle on 5/1/22.
//

import SwiftUI

struct HistoryView: View {
    @Binding var expression: String
    @Binding var historyIndex: Int
    @EnvironmentObject var historyStore: HistoryStore
    
    var body: some View {
        // this is an upside down scroll view to show history of expressions and solutions
        ScrollView(.vertical, showsIndicators: false, content: {
            ScrollViewReader { value in
                
                LazyVStack(alignment: .center, spacing: nil, content: {
                    
                    // this is reversed order since it is flipped
                    ForEach(historyStore.history) { item in
                        VStack {
                            HStack {
                                Text(item.solution)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .font(.title2)
                                    .onTapGesture {
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
                            Text(item.expression)
                                .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.body)
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    expression += item.expression
                                    
                                }
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
                    
                })
            }
        }).rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
    }
}
