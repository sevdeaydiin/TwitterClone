//
//  PostTweetView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 1/1/25.
//

import SwiftUI

struct PostTweetView: View {
    @State var tweet = ""
    @ObservedObject var viewModel = TweetViewModel(tweetManager: TweetManager(networkManager: NetworkManager()))
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        if let user = authViewModel.currentUser {
            VStack {
                Navbar(action: {
                    Task {
                        await viewModel.postTweet(text: tweet, username: user.username, userId: user.id)
                        print(user.username)
                        print(tweet)
                    }
                })
                MultilineTextField(text: $tweet)
                
            }
            .padding()
        }
        
    }
}

#Preview {
    PostTweetView()
}

private struct Navbar: View {
    @Environment(\.dismiss) var dismiss
    var action: (() -> Void)
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text(LocaleKeys.General.cancel.rawValue.locale())
            }
            Spacer()
            Button {
                action()
            } label: {
                Text("Tweet")
                    .padding()
            }
            .background(.twitterBlue)
            .foregroundStyle(.white)
            .clipShape(Capsule())

        }
    }
}
