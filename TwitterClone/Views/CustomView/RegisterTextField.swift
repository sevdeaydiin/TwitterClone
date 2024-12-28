//
//  RegisterTextField.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/28/24.
//

import SwiftUI

struct RegisterTextField: View {
    var placeholder: LocalizedStringKey
    @Binding var text: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundStyle(.gray)
                }
                TextField("", text: $text)
                    .frame(height: 45)
                    .foregroundStyle(.twitterBlue)
            }
            Rectangle()
                .frame(height: 1, alignment: .center)
                .foregroundStyle(.gray)
                .padding(.top, -2)
        }
        .padding(.horizontal)
    }
}
