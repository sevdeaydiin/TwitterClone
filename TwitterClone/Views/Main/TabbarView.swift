//
//  TabbarView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/29/24.
//

import SwiftUI

struct TabbarView: View {
    @State var selectedIndex = 0
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
            }
        }
    }
}

#Preview {
    TabbarView()
}
