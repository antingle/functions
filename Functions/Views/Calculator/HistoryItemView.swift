//
//  HistoryItemView.swift
//  Functions
//
//  Created by Anthony Ingle on 9/5/22.
//

import SwiftUI

struct HistoryItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \History.timestamp, ascending: false)],
            animation: .default)
        private var history: FetchedResults<History>
    var item: History
    @Binding var expression: String
    @Binding var historyIndex: Int
    @Binding var shouldMoveCursorToEnd: Bool
     var value: ScrollViewProxy
    @State private var showButtons = false
    @State private var onHoverClear = false
    @State private var onHoverCopy = false
    @State private var onHoverSolution = false
    @State private var onHoverExpression = false
    @AppStorage("accentColor") private var accentColor = "indigo"
    
    
    var body: some View {
        VStack {
            
            // MARK: - Solution (on the right)
            HStack {
                
                if showButtons {
                    // delete item button
                    Button {
                        deleteItem()
                    } label: {
                        Image(systemName: "xmark").foregroundColor(onHoverClear ? .red : .secondary)
                    }.buttonStyle(.plain)
                        .onHover { over in
                            onHoverClear = over
                        }
                    
                    // copy solution button
                    Button {
                        let pasteBoard = NSPasteboard.general
                        pasteBoard.clearContents()
                        pasteBoard.writeObjects([item.solution! as NSString])
                    } label: {
                        Image(systemName: "doc.on.doc").foregroundColor(onHoverCopy ? Color(accentColor) : .secondary)
                    }.buttonStyle(.plain)
                        .onHover { over in
                            onHoverCopy = over
                        }
                }
                
                // this is reversed order since it is a ScrollView flipped upside down
                Text(item.solution ?? "")
                    .font(.title2)
                    .onHover { over in
                        onHoverSolution = over
                    }
                    .onTapGesture {
                        shouldMoveCursorToEnd = true
                        expression += item.solution!
                    }
                    // I am very very sorry for this confusing tertiary statement
                    // It basically says: change color to accentColor if selected with arrow keys
                    // And/or it is hovered on
                    .foregroundColor(historyIndex != -1 ?
                        (item.id == history[historyIndex].id ? Color(accentColor) :
                        onHoverSolution ? Color(accentColor) : .primary) :
                        onHoverSolution ? Color(accentColor) : .primary)
                    .id(item.id)
                    
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
            .padding(.top, 2)
            
            // MARK: - Expression (on the left)
            Text(item.expression ?? "")
                .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                .font(.body)
                .foregroundColor(onHoverExpression ? Color(accentColor) : .gray)
                .onHover { over in
                    onHoverExpression = over
                }
                .onTapGesture {
                    shouldMoveCursorToEnd = true
                    expression += item.expression!
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            // TODO: Make this an option?
//                                .padding(.bottom, 2)
//                                .overlay(Rectangle().frame(width: nil, height: 0.3, alignment: .bottom).foregroundColor(Color.gray), alignment: .bottom)
            
        }
        .onHover { over in
                showButtons = over
        }
        .padding(.bottom, 4)
        .onChange(of: historyIndex) { newIndex in
            withAnimation {
                if newIndex != -1 {
                    value.scrollTo(history[newIndex].id)
                }
                else if !history.isEmpty
                {
                    value.scrollTo(history[0].id)
                }
            }
        }
    }
    
    private func deleteItem() {
        withAnimation {
            viewContext.delete(item)
            do {
                try viewContext.save()
            } catch {
                // TODO: Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



//struct HistoryItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryItemView()
//    }
//}
