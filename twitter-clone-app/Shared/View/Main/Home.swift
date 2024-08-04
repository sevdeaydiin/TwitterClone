//
//  Home.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 15.07.2024.
//

import SwiftUI

struct Home: View {
    
    @State var showCreateTweet = false
    
    var body: some View {
        VStack {
            ZStack {
                TabView {
                    Feed()
                        .toolbar(.hidden)
                        .onTapGesture {
                            
                        }
                        .tabItem {
                              Image("Home")
                            
                        }
                        .tag(0)
                        
                    SearchView()
                        .toolbar(.hidden)
                        .onTapGesture {
                           
                        }
                        .tabItem {
                            
                                Image("Search")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color.bg)
                            
                        }
                        .tag(1)
                    
                    NotificationsView()
                        .toolbar(.hidden)
                        .onTapGesture {
                            
                        }
                        .tabItem {
                            
                                Image("Notifications")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color.bg)
                            
                        }
                        .tag(2)
                    
                    MessagesView()
                        .toolbar(.hidden)
                        .onTapGesture {
                           
                           
                        }
                        .tabItem {
                            
                                Image("Messages")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color.bg)
                          
                        }
                        .tag(3)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        //if self.selectedIndex == 3 {
                            Button {
                                self.showCreateTweet.toggle()
                            } label: {
                                Image(systemName: "plus.message.fill")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    //.renderingMode(.template)
                                    //.resizable()
                                    .frame(width: 20, height: 20)
                                    .padding()
                                    .background(Color.bg)
                                    
                                    .clipShape(Circle())
                        }
                        //}
                        /*else {
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
                        }*/
                        
                    }.padding()
                }.padding(.bottom, 50)
            }
        }.sheet(isPresented: $showCreateTweet, content: {
            CreateTweetView(show: $showCreateTweet)
        })
    }
}

#Preview {
    Home()
}
