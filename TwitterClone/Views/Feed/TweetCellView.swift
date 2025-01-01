//
//  TweetCellView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/21/24.
//

import SwiftUI
import Kingfisher

struct TweetCellView: View {

    let tweet: Tweet
    
    var body: some View {
        VStack {
            
            HStack(alignment: .top, spacing: 10) {
                KFImage(URL(string: "http://localhost:3000/users/66f079b9a02ee59b751ea757/avatar"))
                    .placeholder {
                        PlaceholderView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                
                
                ///
                VStack(alignment: .leading, spacing: 6) {
                    Text(tweet.username)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    +
                    Text(" @\(tweet.username)")
                        .foregroundStyle(.gray)
                    
                    Text(tweet.text)
                        .frame(maxHeight: 100, alignment: .top)
                }
                Spacer()
            }
            /// Comments, retweet, like, bookmark, share
            CellBottom()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 10)
    }
}

#Preview {
    TweetCellView(tweet: Tweet.mockData)
}

private struct PlaceholderView: View {
    var body: some View {
        Image(systemName: "person")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 75, height: 75)
            .clipShape(Circle())
    }
}
private struct TweetCellBottom: View {
    let image: String
    
    var body: some View {
        Button {
            
        } label: {
            Image(image)
                .resizable()
                .frame(width: 18, height: 18)
        }.foregroundStyle(.gray)
    }
}

private struct CellBottom: View {
    var body: some View {
        HStack(spacing: 50) {
            TweetCellBottom(image: "comments")
            TweetCellBottom(image: "retweet")
            
            Button {
                //if(self.didLike) {
                //    self.viewModel.unlike()
                //} else {
                //    self.viewModel.like()
                //}
            } label: {
                
                //if(self.didLike == false) {
                Image("heart")
                    .resizable()
                    .frame(width: 18, height: 18)
                //} else {
                //                    Image(systemName: "heart.fill")
                //                        .resizable()
                //                        .renderingMode(.template)
                //                        .foregroundStyle(.pink)
                //                        .frame(width: 18, height: 15)
                //                }
                
            }.foregroundStyle(.gray)
            
            HStack(spacing: 20) {
                TweetCellBottom(image: "bookmark")
                TweetCellBottom(image: "upload")
            }
        }
        .padding(.top, 4)
        .padding(.leading, 15)
    }
}
