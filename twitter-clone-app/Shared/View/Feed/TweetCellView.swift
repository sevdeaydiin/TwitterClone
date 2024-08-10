//
//  TweetCellView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 18.07.2024.
//

import SwiftUI

struct TweetCellView: View {
           
    @ObservedObject var viewModel: TweetCellViewModel
    
    init(viewModel: TweetCellViewModel) {
        self.viewModel = viewModel
        print("cell view: \(viewModel.tweet)")
    }
    
    var body: some View {
        VStack {
            HStack (alignment: .top, spacing: 10) {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                    
                VStack (alignment: .leading, spacing: 6) {
                    Text("\(self.viewModel.tweet.username) ")
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    +
                    Text("@\(self.viewModel.tweet.username)")
                        .foregroundStyle(.gray)
                    
                    Text(self.viewModel.tweet.text)
                        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
                    
                    /*if let image = tweetImage {
                        GeometryReader { proxy in
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: proxy.frame(in: .global).width, height: 250)
                                .cornerRadius(15)
                        }.frame(height: 250)
                    }*/
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
                
                HStack(spacing: 20) {
                    Button {
                        
                    } label: {
                        Image(systemName: "bookmark")
                            .resizable()
                            .frame(width: 18, height: 14)
                    }.foregroundStyle(.gray)
                    
                    Button {
                        
                    } label: {
                         Image("upload")
                            .resizable()
                            .frame(width: 18, height: 15)
                    }.foregroundStyle(.gray)
                }
            }
            .padding(.top, 4)
            .padding(.leading, 15)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 10)
        //.padding(.leading, 10)
        //.padding(.top, 15)
    }
}

