//
//  SecureTextField.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/15/24.
//

import SwiftUI

struct SecureAuthTextField: View {
    var placeholder: LocalizedStringKey
    @Binding var password: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading, content: {
                if password.isEmpty {
                    Text(placeholder)
                        .foregroundStyle(.gray)
                }
                SecureField("", text: $password)
                    .frame(height: 45)
                    .foregroundStyle(.twitterBlue)
            })
            
            Rectangle()
                .frame(height: 1, alignment: .center)
                .foregroundStyle(.gray)
                .padding(.top, -2)
        }
        .padding(.horizontal)
    }
}

