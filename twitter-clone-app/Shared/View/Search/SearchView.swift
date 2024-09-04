//
//  SearchView.swift
//  twitter-clone-apps
//
//  Created by Sevde Aydın on 15.07.2024.
//

import SwiftUI

struct SearchView: View {
    
    @State var text = ""
    @State var isEditing = false
    
    @ObservedObject var viewModel = SearchViewModel()
    
    var users: [User] {
        return text.isEmpty ? viewModel.users : viewModel.filteredUsers(text)
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $text, isEditing: $isEditing)
            
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(users) { user in
                        NavigationLink(destination: UserProfile(user: user)) {
                            SearchUserCell(user: user)
                            .padding(.leading)
                        }
                    }
                }
            
            /*ScrollView (showsIndicators: false) {
                if !isEditing {
                    List(0..<9) { i in
                        SearchCell(tag: "hello", tweets: String(i))
                    }.listStyle(.inset)
                } else {
                    List(0..<9) { user in
                        SearchUserCell()
                    }.listStyle(.inset)
                }
 */           }
        }
        .padding(.top, 10)
    }
}
