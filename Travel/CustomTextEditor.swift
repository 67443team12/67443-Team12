//
//  CustomTextEditor.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/11/25.
//

import SwiftUI
import UIKit

struct CustomTextEditor: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var backgroundColor: UIColor
    var font: UIFont

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.backgroundColor = backgroundColor
        textView.font = font
        textView.text = placeholder
        textView.textColor = .lightGray
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if text.isEmpty && !uiView.isFirstResponder {
            uiView.text = placeholder
            uiView.textColor = .lightGray
        } else if uiView.text == placeholder && uiView.isFirstResponder {
            uiView.text = ""
            uiView.textColor = .black
        } else if uiView.text != placeholder {
            uiView.text = text
            uiView.textColor = .black
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextEditor

        init(_ parent: CustomTextEditor) {
            self.parent = parent
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.placeholder {
                textView.text = ""
                textView.textColor = .black
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholder
                textView.textColor = .lightGray
            }
        }

        func textViewDidChange(_ textView: UITextView) {
            // Avoid setting the placeholder as part of the content
            if textView.text != parent.placeholder {
                parent.text = textView.text
            }
        }
    }
}
