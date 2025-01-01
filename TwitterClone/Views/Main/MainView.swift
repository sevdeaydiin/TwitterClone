//
//  MainView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/21/24.
//

import SwiftUI

struct MainView: View {
    let user: User
    @State var width = UIScreen.main.bounds.width - 90
    @State var x = -UIScreen.main.bounds.width + 90
    @State private var isUserProfileActive = false
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                VStack {
                    NavbarView(x: $x)
                    TabbarView(user: user)
                }
                .overlay(
                    Color.black.opacity(x == 0 ? 0.5 : 0)
                )
                .offset(x: x == 0 ? width : 0)
                
                SlideMenu(viewModel: AuthViewModel(authManager: AuthManager(networkManager: NetworkManager())))
                    .shadow(color: .black.opacity(x != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                    .offset(x: x)
                    .ignoresSafeArea(.all, edges: .vertical)
                    .onTapGesture {
                        withAnimation {
                            x = -width
                        }
                    }
                    .gesture(DragGesture().onChanged({ (value) in
                        withAnimation {
                            if value.translation.width > 0 {
                                if x < 0 {
                                    x = -width + value.translation.width
                                }
                            } else {
                                if x != -width {
                                    x = value.translation.width
                                }
                            }
                        }
                    })
                        .onEnded({ (value) in
                            withAnimation {
                                if -x < width / 2 {
                                    x = 0
                                } else {
                                    x = -width
                                }
                            }
                        })
                    )
            }
//            .onTapGesture {
//                withAnimation {
//                    x = -width
//                }
//            }
            .toolbar(.hidden)
            .navigationTitle("")
            .navigationDestination(isPresented: $isUserProfileActive) {
                UserProfile()
            }
            .padding(.top, UIScreen.main.bounds.height * 0.05)
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    MainView(user: User.mockData)
}
