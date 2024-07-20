//
//  SecureAuthTextField.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 21.07.2024.
//

import SwiftUI

struct SecureAuthTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading, content: {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundStyle(.gray)
                }
                SecureField("", text: $text)
                    .frame(height: 45)
                    .foregroundStyle(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
            })
            
            Rectangle()
                .frame(height: 1, alignment: .center)
                .foregroundStyle(.gray)
                .padding(.top, -2)
        }
        .padding(.horizontal)
    }
}

