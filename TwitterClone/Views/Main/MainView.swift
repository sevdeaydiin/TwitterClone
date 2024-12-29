//
//  MainView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/21/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    let user: User
    @State var width = UIScreen.main.bounds.width - 90
    @State var x = -UIScreen.main.bounds.width + 90
    @State private var isUserProfileActive = false
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                VStack {
                    NavbarView(x: $x)
                    TabbarView()
                }
                .overlay(
                    Color.black.opacity(x == 0 ? 0.5 : 0)
                )
                .offset(x: x == 0 ? width : 0)
            }
        }
    }
}

#Preview {
    MainView(user: User.mockData)
}
