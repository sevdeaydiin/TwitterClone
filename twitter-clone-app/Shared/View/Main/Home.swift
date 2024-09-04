//
//  Home.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 15.07.2024.
//

import SwiftUI

struct Home: View {
    
    @State var showCreateTweet = false
    @State var selectedIndex = 2
    @Binding var x: CGFloat
    let user: User
    
    var body: some View {
        VStack {
            ZStack {
                TabView(selection: $selectedIndex) {
                    Feed(user: user)

                        .tabItem { Image(systemName: "house") }
                        .tag(0)
                    
                    SearchView()

                        .tabItem { Image(systemName: "magnifyingglass") }
                        .tag(1)
                    
                    NotificationsView(user: user)

                        .tabItem { Image(systemName: "bell") }
                        .tag(2)
                    
                    MessagesView()
                        //.toolbar(.hidden)

                        .tabItem {
                            Image("Messages")
                                .renderingMode(.template)
                                .foregroundStyle(Color.bg)
                        }
                        .tag(3)
                    
                    /*Feed(user: user)
                     .onTapGesture {
                     selectedIndex = 0
                     }
                     .toolbar(.hidden)
                     .tabItem {
                     Image("Home")
                     
                     }
                     .tag(0)
                     
                     SearchView()
                     .onTapGesture {
                     selectedIndex = 1
                     }
                     .toolbar(.hidden)
                     .tabItem {
                     if(selectedIndex == 1) {
                     Image(systemName: "magnifyingglass")
                     .renderingMode(.template)
                     .foregroundStyle(Color.bg)
                     } else {
                     Image(systemName: "magnifyingglass")
                     .renderingMode(.template)
                     .foregroundStyle(Color.bg)
                     }
                     
                     }
                     .tag(1)
                     
                     NotificationsView()
                     .toolbar(.hidden)
                     .onTapGesture {
                     selectedIndex = 2
                     }
                     .tabItem {
                     Image(systemName: "bell")
                     .renderingMode(.template)
                     .foregroundStyle(Color.bg)
                     
                     }
                     .tag(2)*/
                    
                    /*MessagesView()
                     .toolbar(.hidden)
                     .onTapGesture {
                     selectedIndex = 3
                     }
                     .tabItem {
                     Image("Messages")
                     .renderingMode(.template)
                     .foregroundStyle(Color.bg)
                     }
                     .tag(3)*/
                }
                //.padding(.bottom, 15)
                
                /*VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        Button {
                            self.showCreateTweet.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            //.renderingMode(.template)
                            //.resizable()
                                .frame(width: 20, height: 20)
                                .padding()
                                .background(Color.bg)
                                .clipShape(Circle())
                        }
                    }.padding()
                }.padding(.bottom, Sizes.height * 0.11)*/
            }
        }
        //.sheet(isPresented: $showCreateTweet, content: {
        //    CreateTweetView(show: $showCreateTweet)
        //})
    }
}
