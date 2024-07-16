//
//  MultilineTextField.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 16.07.2024.
//

import SwiftUI

struct MultilineTextField: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeCoordinator() -> MultilineTextField.Coordinator {
        return MultilineTextField.Coordinator(parent1: self)
    }
    
    func makeUIView(context: Context) -> some UITextView {
        let text = UITextView()
        //text.allowsEditingTextAttributes = true
        text.isEditable = true
        text.isUserInteractionEnabled = true
        text.text = "What's happening?"
        text.textColor = .gray
        text.font = .systemFont(ofSize: 20)
        text.delegate = context.coordinator
        return text
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultilineTextField
        
        init(parent1: MultilineTextField) {
            parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .black
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }
}
