//
//  AuthTextField.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/15/24.
//

import SwiftUI

struct AuthTextField: View {
    
    var placeholder: LocalizedStringKey
    @Binding var email: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading, content: {
                if email.isEmpty {
                    Text(placeholder)
                        .foregroundStyle(.gray)
                }
                TextField("", text: $email)
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
