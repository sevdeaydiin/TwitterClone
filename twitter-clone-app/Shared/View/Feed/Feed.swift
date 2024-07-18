//
//  Feed.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 15.07.2024.
//

import SwiftUI

struct Feed: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack (spacing: 18) {
                TweetCellView(tweet: "Hey Tim", tweetImage: "post")
                Divider()
                ForEach(1...10, id: \.self) { _ in
                    TweetCellView(tweet: text)
                    Divider()
                }
            }
            .padding(.top)
            .padding(.horizontal)
            .zIndex(0)
        }
    }
}

#Preview {
    Feed()
}
