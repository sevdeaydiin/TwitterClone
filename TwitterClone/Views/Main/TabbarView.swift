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
                    FeedView(viewModel: TweetViewModel(tweetManager: TweetManager(networkManager: NetworkManager())))
                        .tabItem { Image(systemName: "house") }
                        .tag(0)
                    SearchView()
                        .tabItem { Image(systemName: "magnifyingglass") }
                        .tag(1)
                    NotificationView()
                        .tabItem { Image(systemName: "bell") }
                        .tag(2)
                    ProfileView()
                        .tabItem { Image(systemName: "person") }
                        .tag(3)
                }
            }
        }
    }
}

#Preview {
    TabbarView()
}
