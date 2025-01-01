//
//  TabbarView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/29/24.
//

import SwiftUI

struct TabbarView: View {
    @State var selectedIndex = 0
    @State var showPostTweet = false
    let user: User
    var body: some View {
        VStack {
            ZStack {
                TabView(selection: $selectedIndex) {
                    FeedView(
                        viewModel: TweetViewModel(tweetManager: TweetManager(networkManager: NetworkManager())), authViewModel: AuthViewModel(authManager: AuthManager(networkManager: NetworkManager()))
                    )
                        .tabItem {
                            Image(systemName: "house")
                                .environment(\.symbolVariants, selectedIndex == 0 ? .fill : .none)
                        }
                        .tag(0)
                    SearchView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                                .environment(\.symbolVariants, selectedIndex == 1 ? .fill : .none)
                        }
                        .tag(1)
                    NotificationView()
                        .tabItem {
                            Image(systemName: "bell")
                                .environment(\.symbolVariants, selectedIndex == 2 ? .fill : .none)
                        }
                        .tag(2)
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person")
                                .environment(\.symbolVariants, selectedIndex == 3 ? .fill : .none)
                        }
                        .tag(3)
                }
                .tint(.text)
                
                /// post tweet
                PostTweetButton(action: {
                    showPostTweet.toggle()
                })
            }
        }
        .sheet(isPresented: $showPostTweet) {
            PostTweetView()
        }
    }
}

#Preview {
    TabbarView(user: User.mockData)
}

private struct PostTweetButton: View {
    var action: (() -> Void)
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    action()
                } label: {
                    Image(systemName: "plus")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 20)
                        .padding()
                        .background(.twitterBlue)
                        .clipShape(Circle())
                }
            }
            .padding()
        }
        .padding(.bottom, 80)
    }
}
