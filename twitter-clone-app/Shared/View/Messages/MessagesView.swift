//
//  MessagesView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 15.07.2024.
//

import SwiftUI

struct MessagesView: View {
    
    @State var text = ""
    @State var isEditing = false
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            SearchBar(text: $text, isEditing: $isEditing)
            Rectangle()
                .frame(width: Sizes.width, height: 1, alignment: .center)
                .foregroundStyle(.gray)
                .opacity(0.3)
                .padding(.bottom, 10)
            LazyVStack {
                ForEach(0..<20) { message in
                    MessageCell()
                }
            }
            
        }
    }
}

#Preview {
    MessagesView()
}
