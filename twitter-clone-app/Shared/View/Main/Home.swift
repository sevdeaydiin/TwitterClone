//
//  Home.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 15.07.2024.
//

import SwiftUI

struct Home: View {
    
    @State var selectedIndex = 0
    @State var showCreateTweet = false
    
    var body: some View {
        VStack {
            ZStack {
                TabView {
                    Feed()
                        .onTapGesture {
                            self.selectedIndex = 0
                        }
                        .tabItem {
                            if (selectedIndex == 0) {
                                Image("Home")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color.bg)
                            } else {
                                Image("Home")
                            }
                        }
                        .tag(0)
                        
                    SearchView()
                        .onTapGesture {
                            self.selectedIndex = 1
                        }
                        .tabItem {
                            if (selectedIndex != 1) {
                                Image("Search")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color.bg)
                            } else {
                                Image("Search")
                            }
                        }
                        .tag(1)
                    
                    NotificationsView()
                        .onTapGesture {
                            self.selectedIndex = 2
                        }
                        .tabItem {
                            if (selectedIndex != 2) {
                                Image("Notifications")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color.bg)
                            } else {
                                Image("Notifications")
                            }
                        }
                        .tag(2)
                    
                    MessagesView()
                        .onTapGesture {
                            self.selectedIndex = 3
                        }
                        .tabItem {
                            if (selectedIndex != 3) {
                                Image("Messages")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color.bg)
                            } else {
                                Image("Messages")
                            }
                        }
                        .tag(3)
                }
                
                VStack {
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
                }.padding(.bottom, 50)
            }
        }.sheet(isPresented: $showCreateTweet, content: {
            CreateTweetView()
        })
    }
}

#Preview {
    Home()
}
