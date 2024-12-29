//
//  FeedView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/17/24.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject private var viewModel: TweetViewModel
    init(viewModel: TweetViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        RefreshableScrollView(
            content:
                ScrollView(showsIndicators: false){
                    ForEach(viewModel.tweets) { tweet in
                        TweetCellView(tweet: tweet)
                        Divider()
                    }
                    .padding(.vertical, 5)
                }
                .padding(.top)
                .zIndex(0)
        ) { control  in
            DispatchQueue.main.async {
                Task {
                    await self.viewModel.fetchTweets()
                }
                control.endRefreshing()
            }
        }
    }
}


