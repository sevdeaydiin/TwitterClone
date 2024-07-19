//
//  SearchView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 15.07.2024.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var isEditing = false
    var body: some View {
        VStack {
            SearchBar(text: $text, isEditing: $isEditing)
            
            if !isEditing {
                List(0..<9) { i in
                    SearchCell(tag: "hello", tweets: String(i))
                }.listStyle(.inset)
            } else {
                List(0..<9) { user in
                    SearchUserCell()
                }.listStyle(.inset)
            }
        }
    }
}

#Preview {
    SearchView()
}
