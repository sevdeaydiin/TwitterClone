//
//  SearchBar.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 1/1/25.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            TextField(LocaleKeys.Search.search.rawValue.locale(), text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
            if isEditing {
                Button {
                    isEditing = false
                    text = ""
                    UIApplication.shared.endEditing()
                } label: {
                    Text("Cancel")
                        .fontWeight(.light)
                        .foregroundStyle(.black)
                        .padding(.trailing, 10)
                }
            }
        }.padding(.horizontal, 15)
            .onTapGesture {
                isEditing = true
            }
    }
}
