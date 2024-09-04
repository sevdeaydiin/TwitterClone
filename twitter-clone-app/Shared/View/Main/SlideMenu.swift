//
//  SlideMenu.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 19.07.2024.
//

import SwiftUI
import Kingfisher

var menuButtons = ["Profile", "Lists", "Topics", "Bookmarks", "Moments"]

struct SlideMenu: View {
    
    @ObservedObject var viewModel: AuthViewModel
    @ObservedObject var profileViewModel: ProfileViewModel
    @Binding var isUserProfileActive: Bool
    @State var show = true
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    
                    //Button {
                    //    isUserProfileActive = true
                    //} label: {
                    if let user = viewModel.currentUser {
                        NavigationLink(destination: UserProfile(user: user)) {
                            KFImage(URL(string: "\(NetworkConstants.baseURL)users/\(user.id)/avatar"))
                                .placeholder({
                                    Image("pp")
                                        .resizable()
                                        //.aspectRatio(contentMode: .fill)
                                        .frame(width: 75, height: 75)
                                        .clipShape(Circle())
                                })
                                .resizable()
                                .frame(width: 60, height: 60, alignment: .center)
                                .clipShape(Circle())
                        }
                        
                    }
                    //                    }
                    
                    HStack(alignment: .top, spacing: 12) {
                        VStack(alignment: .leading) {
                            //Button {
                            //    isUserProfileActive = true
                            //} label: {
                            
                            if let user = viewModel.currentUser {
                                NavigationLink(destination: UserProfile(user: user)) {
                                    Text(user.name)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.black)
                                }
                                Text("@\(user.username)")
                                    .foregroundStyle(.gray)
                            }
                            
                            HStack(spacing: 20) {
                                FollowView(count: 10, title: "Following")
                                FollowView(count: 8, title: "Followers")
                            }.padding(.top, 10)
                            
                        }
                    }
                    //}
                    Divider()
                        .padding(.top, 10)
                }
                Spacer()
                Button {
                    withAnimation {
                        self.show.toggle()
                    }
                } label: {
                    Image(systemName: show ? "chevron.down" : "chevron.up")
                        .foregroundStyle(.bg)
                }
            }
            
            VStack(alignment: .leading) {
                
                ForEach(menuButtons, id: \.self) { item in
                    MenuButton(title: item)
                }
                
                Divider()
                    .padding(.top)
                
                Button {
                    viewModel.logout()
                } label: {
                    MenuButton(title: "Twitter Ads")
                }
                
                Divider()
                
                Button {
                    
                } label: {
                    Text("Settings and privacy")
                        .foregroundStyle(.black)
                }.padding(.top, 20)
                Button {
                    
                } label: {
                    Text("Help center")
                        .foregroundStyle(.black)
                }
                Spacer()
                Divider()
                    .padding(.bottom)
                
                HStack {
                    Button {
                        
                    } label: {
                        Image("help")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundStyle(.bg)
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Image("barcode")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundStyle(.bg)
                    }
                }
            }
            .opacity(show ? 1 : 0)
            .frame(height: show ? nil : 0)
            
            
            VStack(alignment: .leading) {
                Button {
                    
                } label: {
                    Text("Create a new account")
                        .foregroundStyle(.bg)
                }
                Button {
                    
                } label: {
                    Text("Add an existing account")
                        .foregroundStyle(.bg)
                }
                
                Spacer()
            }
            .opacity(!show ? 1 : 0)
            .frame(height: !show ? nil : 0)
            .padding(.top, 10)
        }
        .padding(.horizontal, 20)
        .padding(.top, edges!.top == 0 ? 15 : edges?.top)
        .padding(.bottom, edges!.bottom == 0 ? 15 : edges?.bottom)
        .frame(width: Sizes.width - 90)
        .background(.white)
        //.padding(.top, -70)
        .ignoresSafeArea(.all, edges: .vertical)
        Spacer()
    }
}

