//
//  UserProfile.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 20.07.2024.
//

import SwiftUI
import Kingfisher

struct UserProfile: View {
    
    @State var offset: CGFloat = 0
    @State var titleOffset: CGFloat = 0
    @State var tabBarOffset: CGFloat = 0
    @State var currentTab = "Tweets"
    @State var editProfileShow = false
    
    @Namespace var animation
    
    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    
    var isCurrentUser: Bool {
        return viewModel.user.isCurrentUser ?? false
    }
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {

        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing: 15) {
                
                GeometryReader { proxy in
                    
                    let minY = proxy.frame(in: .global).minY
                    
                    //DispatchQueue.main.async {
                    //    self.offset = minY
                    //}
                    
                    //return AnyView {
                        ZStack {
                            Image("banner")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: Sizes.width, height: minY > 0 ? 180 + minY : 180, alignment: .center)
                                .cornerRadius(0)
                            
                            BlurView()
                                .opacity(blurViewOpacity())
                            
                            VStack(spacing: 5) {
                                Text(self.user.name)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                
                                Text("150 tweets")
                                    .foregroundStyle(.white)
                            }
                            .offset(y: 120)
                            .offset(y: titleOffset > 100 ? 0 : -getTitleOffset())
                            .opacity(titleOffset < 100 ? 1 : 0)
                        }
                            .clipped()
                            .frame(height: minY > 0 ? 180 + minY : nil)
                            .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                            .onChange(of: minY) { newValue in
                                self.offset = newValue
                            }
                        //}
                }
                .frame(height: 180)
                .zIndex(1)
                
                VStack {
                    HStack {
                        KFImage(URL(string: "http://localhost:3000/users/\(self.viewModel.user.id)/avatar"))
                            .placeholder({
                                Image("pp")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                            })
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(5)
                            .background(Color.white.clipShape(Circle()))
                            .offset(y: offset < 0 ? getOffset() - 20 : -20)
                            .scaleEffect(getScale())
                        
                        Spacer()
                        
                        if(self.isCurrentUser) {
                            Button(action: {
                                self.editProfileShow.toggle()
                            }, label: {
                                Text("Edit Profile")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 5)
                                    .background(Capsule().stroke(Color.gray, lineWidth: 1.5))
                            })
                            .sheet(isPresented: $editProfileShow) {
                             } content: {
                                 EditProfileView(user: $viewModel.user)
                            }
                        } else {
                            Button(action: {
                                self.viewModel.follow()
                            }, label: {
                                Text("Follow")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 10)
                                    .background(
                                        Capsule()
                                            //.stroke(Color.black, lineWidth: 1.5)
                                            .foregroundStyle(.black)
                                        
                                    )
                            })
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, -25)
                    .padding(.bottom, -10)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 3, content: {
                            
                            VStack (alignment: .leading, spacing: 3){
                                Text(self.viewModel.user.name)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)
                                    .font(.system(size: Sizes.width * 0.06)) // Dynamic font size
                                
                                Text("@\(self.viewModel.user.username)")
                                    .foregroundStyle(.gray)
                            }
                            //if let bio = user.bio {
                            //    Text(bio)
                            //        .frame(maxWidth: .infinity, alignment: .leading)
                            //}
                            
                            HStack(spacing: 8) {
                                if let userBio = viewModel.user.bio {
                                    if (userBio != "") {
                                            Text(userBio)
                                                .foregroundStyle(.gray)
                                                .font(.system(size: 14))
                                        }
                                    }
                            }.frame(maxWidth: .infinity, alignment: .leading)

                            HStack(spacing: 8) {
                                if let userLocation = viewModel.user.location {
                                    if (userLocation != "") {
                                        HStack(spacing: 2) {
                                            Image(systemName: "mappin.and.ellipse")
                                                .frame(width: 24, height: 24)
                                                .foregroundStyle(.gray)
                                            Text(userLocation)
                                                .foregroundStyle(.gray)
                                                .font(.system(size: 14))
                                        }
                                    }
                                }
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack(spacing: 8) {
                                if let userWebsite = viewModel.user.website {
                                    if (userWebsite != "") {
                                        HStack(spacing: 2) {
                                            Image(systemName: "link")
                                                .frame(width: 24, height: 24)
                                                .foregroundStyle(.gray)
                                            Text(userWebsite)
                                                .foregroundStyle(.gray)
                                                .font(.system(size: 14))
                                        }
                                    }
                                }
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack(spacing: 5) {
                                Text("13")
                                    .foregroundStyle(.primary)
                                    .fontWeight(.semibold)
                                Text("Followers")
                                    .foregroundStyle(.gray)
                                Text("60")
                                    .foregroundStyle(.primary)
                                    .fontWeight(.semibold)
                                    .padding(.leading, 10)
                                Text("Following")
                                    .foregroundStyle(.gray)
                            }
                            .padding(.top, 5)
                        })
                        .padding(.leading, 5)
                        .overlay {
                            GeometryReader { proxy -> Color in
                                let minY = proxy.frame(in: .global).minY
                                
                                DispatchQueue.main.async {
                                    self.titleOffset = minY
                                }
                                return Color.clear
                            }
                            .frame(width: 0, height: 0, alignment: .top)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 5)
                    //.frame(alignment: .leading)
                    
                    // tweets - media - likes
                    VStack(spacing: 0) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                TabButton(title: "Tweets", currentTab: $currentTab, animation: animation)
                                TabButton(title: "Replies", currentTab: $currentTab, animation: animation)
                                TabButton(title: "Media", currentTab: $currentTab, animation: animation)
                                TabButton(title: "Likes", currentTab: $currentTab, animation: animation)
                            }
                        }
                        
                        Divider()
                    }
                    .padding(.top, -65)
                    .background(Color.white)
                    .offset(y: tabBarOffset < 90 ? -tabBarOffset + 90 : 90)
                    .overlay(
                        GeometryReader { proxy -> Color in
                            
                            let minY = proxy.frame(in: .global).minY
                            
                            DispatchQueue.main.async {
                                self.tabBarOffset = minY
                            }
                            return Color.clear
                        }
                        .frame(width: 0, height: 0, alignment: .top)
                    )
                    .zIndex(1)
                    
                    // tweet
                    VStack(spacing: 18) {
                        ForEach(viewModel.tweets) { tweet in
                            TweetCellView(viewModel: TweetCellViewModel(tweet: tweet))
                        }
                    }
                    .padding(.top, 60)
                    .zIndex(0)
                }
                //.padding(.horizontal)
                .zIndex(-offset > 80 ? 0 : 1)
            }
        })
        .ignoresSafeArea(.all, edges: .top)
    }
    
    func blurViewOpacity() -> Double {
        let progress = -(offset + 80) / 150
        return Double(-offset > 80 ? progress : 0)
    }
    
    func getTitleOffset() -> CGFloat {
        let progress = 20 / titleOffset
        let offset = 60 * (progress > 0 && progress <= 1 ? progress : 1)
        return offset
    }
    
    func getOffset() -> CGFloat {
        let progress = (-offset / 80) * 20
        return progress <= 20 ? progress : 20
    }
    
    func getScale() -> CGFloat {
        let progress = -offset / 80
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        return scale < 1 ? scale : 1
    }
}
