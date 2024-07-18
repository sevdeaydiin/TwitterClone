//
//  TweetCellView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 18.07.2024.
//

import SwiftUI

struct TweetCellView: View {
    
    var tweet: String
    var tweetImage: String?
    
    
    var body: some View {
        VStack {
            HStack (alignment: .top, spacing: 10) {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                    
                VStack (alignment: .leading, spacing: 10) {
                    Text("sevde ")
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    +
                    Text("@sevdeaydiin")
                        .foregroundStyle(.gray)
                    
                    Text(tweet)
                        .frame(maxHeight: 100, alignment: .top)
                    
                    if let image = tweetImage {
                        GeometryReader { proxy in
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: proxy.frame(in: .global).width, height: 250)
                                .cornerRadius(15)
                        }.frame(height: 250)
                    }
                }
            }
            
            // Cell bottom
            HStack (spacing: 50) {
                Button {
                    
                } label: {
                     Image("Comments")
                        .resizable()
                        .frame(width: 16, height: 16)
                }.foregroundStyle(.gray)
                
                Button {
                    
                } label: {
                    Image("Retweet")
                        .resizable()
                        .frame(width: 18, height: 14)
                }.foregroundStyle(.gray)
                
                Button {
                    
                } label: {
                     Image(systemName: "heart")
                        .resizable()
                        .frame(width: 18, height: 15)
                }.foregroundStyle(.gray)
                
                Button {
                    
                } label: {
                     Image("upload")
                        .resizable()
                        .frame(width: 18, height: 15)
                }.foregroundStyle(.gray)
            }.padding(.top, 4)
        }
    }
}

#Preview {
    TweetCellView(tweet: text)
}

var text = "nasıl iş bulcaz bilmiyorum nasıl olacak"
