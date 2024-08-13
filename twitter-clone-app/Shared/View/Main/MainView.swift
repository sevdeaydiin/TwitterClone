//
//  MainView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 19.07.2024.
//

import SwiftUI

struct MainView: View {
    let user: User
    
    @State var width = Sizes.width - 90
    @State var x = -Sizes.width + 90
    @State private var isUserProfileActive = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                VStack {
                    TopBar(x: $x)
                    Home(x: $x, user: user)
                }
                .overlay(
                    Color.black.opacity(x == 0 ? 0.5 : 0)
                )
                .offset(x: x == 0 ? width : 0)
                
                SlideMenu(viewModel: AuthViewModel.shared, profileViewModel: ProfileViewModel.init(user: user), isUserProfileActive: $isUserProfileActive)
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
            .onTapGesture {
                withAnimation {
                    x = -width
                }
            }
            .toolbar(.hidden)
            .navigationTitle("")
            .navigationDestination(isPresented: $isUserProfileActive) {
                UserProfile(user: user)
            }
            //.frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, Sizes.height * 0.05)
        }
    }
}


