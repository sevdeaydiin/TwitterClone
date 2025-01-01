//
//  FeedView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/17/24.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject private var viewModel: TweetViewModel
    @StateObject private var authViewModel: AuthViewModel
    init(viewModel: TweetViewModel, authViewModel: AuthViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _authViewModel = StateObject(wrappedValue: authViewModel)
    }
    
    var body: some View {
        if let currentUser = authViewModel.currentUser {
            RefreshableScrollView(
                content:
                    ScrollView(showsIndicators: false){
                        ForEach(viewModel.tweets) { tweet in
                            TweetCellView(tweet: tweet, currentUser: currentUser)
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
}

