//
//  UserProfile.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 20.07.2024.
//

import SwiftUI

struct UserProfile: View {
    
    @State var offset: CGFloat = 0
    @State var titleOffset: CGFloat = 0
    @State var currentTab = "Tweets"
    @State var tabBarOffset: CGFloat = 0
    @Namespace var animation
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    GeometryReader { proxy -> AnyView in
                        
                        let minY = proxy.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
                            self.offset = minY
                        }
                        
                        return AnyView(
                            ZStack {
                                Image("banner")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: width, height: minY > 0 ? 180 + minY : 180, alignment: .center)
                                    .cornerRadius(0)
                                
                                BlurView()
                                    .opacity(blurViewOpacity())
                                
                                VStack(spacing: 5) {
                                    Text("sevde")
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
                        )
                    }
                    .frame(height: 180)
                    .zIndex(1)
                    
                    VStack {
                        HStack {
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(8)
                                .background(Color.white.clipShape(Circle()))
                                .offset(y: offset < 0 ? getOffset() - 20 : -20)
                                .scaleEffect(getScale())
                            Spacer()
                            Button {
                                
                            } label: {
                                 Text("Edit Profile")
                                    .foregroundStyle(.blue)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background(Capsule().stroke(Color.blue, lineWidth: 1.5))
                            }
                        }
                        .padding(.top, -25)
                        .padding(.bottom, -10)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("sevde")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                                .font(.system(size: width * 0.06)) // Dynamic font size
                            
                            Text("@sevde")
                                .foregroundStyle(.gray)
                            
                            Text("gırgır samata hjkshjs shjhashaj bsaj ah ahsajhhsah")
                            
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
                        }
                        .overlay {
                            GeometryReader { proxy -> Color in
                                let minY = proxy.frame(in: .global).minY
                                
                                DispatchQueue.main.async {
                                    self.titleOffset = minY
                                }
                                return Color.clear
                            }
                            .frame(width: 0, height: 0, alignment: .top)
                            
                            VStack(spacing: 0) {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        TabButton(title: "Tweets", currentTab: $currentTab, animation: animation)
                                        TabButton(title: "Tweets & Likes", currentTab: $currentTab, animation: animation)
                                        TabButton(title: "Media", currentTab: $currentTab, animation: animation)
                                        TabButton(title: "Likes", currentTab: $currentTab, animation: animation)
                                    }
                                }
                                Divider()
                            }
                            .padding(.top, 30)
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
                            
                            
                        }
                    }.zIndex(1)
                    
                    VStack(spacing: 18, content: {
                        TweetCellView(tweet: "işte böyle", tweetImage: "logo")
                        TweetCellView(tweet: "selam hello naber iyidir jasn shahsa gaghsa ahgsh hjs dhk sjhah")
                    })
                        
                    
                }
            }
        }
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

#Preview {
    UserProfile()
}
