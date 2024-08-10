//
//  CustomProfileTextField.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 10.08.2024.
//

import SwiftUI

struct CustomProfileTextField: View {
    
    @Binding var message: String
    var placeholder: String
    
    var body: some View {
        HStack {
            ZStack {
                HStack {
                    if message.isEmpty {
                        Text(placeholder)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                }
                TextField("", text: $message)
                    .foregroundStyle(.blue)
            }
        }
    }
}
