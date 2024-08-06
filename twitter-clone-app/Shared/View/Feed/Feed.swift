//
//  Feed.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 15.07.2024.
//

import SwiftUI

struct Feed: View {
    
    let user: User
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack (spacing: 18) {
                
                ForEach(viewModel.tweets) { tweet in
                    TweetCellView(viewModel: TweetCellViewModel(tweet: tweet))
                    Divider()
                }
            }
            .padding(.top)
            //.padding(.horizontal)
            .zIndex(0)
        }
    }
}

