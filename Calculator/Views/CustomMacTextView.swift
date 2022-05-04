//
//  CustomMacTextView.swift
//
//  Foundation by Marc Maset - 2021
//  Changes inspired from MacEditorTextView by Thiago Holanda
//
//  Modified by Anthony Ingle - 2022
//

import SwiftUI

struct CustomMacTextView: NSViewRepresentable {
    
    var placeholderText: String?
    @Binding var text: String
    var font: NSFont = .systemFont(ofSize: 14, weight: .regular)
    
    var onSubmit        : () -> Void       = {}
    var onTextChange    : (String) -> Void = { _ in }
    var onEditingChanged: () -> Void       = {}
    
    var onMoveUp        : () -> Void       = {}
    var onMoveDown      : () -> Void       = {}
    fileprivate let scrollView = PlaceholderNSTextView.scrollableTextView()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeNSView(context: Context) -> NSScrollView {
        guard let textView = scrollView.documentView as? PlaceholderNSTextView else {
            return scrollView
        }
        
        textView.delegate = context.coordinator
        textView.string = text
        textView.drawsBackground = false
        textView.font = font
        textView.allowsUndo = true
        textView.placeholderText = placeholderText
        scrollView.hasVerticalScroller = false
        
        return scrollView
    }
    
    func updateNSView(_ view: NSScrollView, context: Context) {
        guard let textView = view.documentView as? NSTextView else {
            return
        }
        
        textView.string = text
    }
    
}

extension CustomMacTextView {
    
    class Coordinator: NSObject, NSTextViewDelegate {
        
        var parent: CustomMacTextView
        
        init(_ parent: CustomMacTextView) {
            self.parent = parent
        }
        
        func textDidBeginEditing(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }
            
            self.parent.text = textView.string
            self.parent.onEditingChanged()
        }
        
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }
            
            // Update text
            self.parent.text = textView.string
            self.parent.onTextChange(textView.string)
        }
        
        func textDidEndEditing(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }
            
            self.parent.text = textView.string
            self.parent.onSubmit()
        }
        
        // handles commands
        func textView(_ textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
            if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
                // Do something when ENTER key pressed
                self.parent.onSubmit()
                return true
                
            } else if (commandSelector == #selector(NSResponder.moveUp(_:))) {
                // Do something when UP ARROW pressed
                self.parent.onMoveUp()
                return true
                
            } else if (commandSelector == #selector(NSResponder.moveDown(_:))) {
                // Do something when DOWN ARROW pressed
                self.parent.onMoveDown()
                return true
            }
            
            // return true if the action was handled; otherwise false
            return false
        }
    }
}

// for setting a proper placeholder text on an NSTextView
fileprivate class PlaceholderNSTextView: NSTextView {
    @objc private var placeholderAttributedString: NSAttributedString?
    var placeholderText: String? {
        didSet {
            var attributes = [NSAttributedString.Key: AnyObject]()
            attributes[.font] = font
            attributes[.foregroundColor] = NSColor.darkGray
            let captionAttributedString = NSAttributedString(string: placeholderText ?? "", attributes: attributes)
            placeholderAttributedString = captionAttributedString
        }
    }
}
