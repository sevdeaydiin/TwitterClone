//
//  TweetCellView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 18.07.2024.
//

import SwiftUI
import Kingfisher

struct TweetCellView: View {
    @ObservedObject var viewModel: TweetCellViewModel
    
    init(viewModel: TweetCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 10) {
                
                if let user = viewModel.user {
                    NavigationLink(destination: UserProfile(user: user)) {
                        KFImage(URL(string: "\(NetworkConstants.baseURL)users/\(self.viewModel.tweet.userId)/avatar"))
                            .placeholder {
                                Image("pp")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                            }
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                    }
                }

                
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("\(self.viewModel.tweet.username) ")
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    +
                    Text("@\(self.viewModel.tweet.username)")
                        .foregroundStyle(.gray)
                    
                    Text(self.viewModel.tweet.text)
                        .frame(maxHeight: 100, alignment: .top)
                    
                    if let imageData = viewModel.tweet.image?.data {
                        if let uiImage = UIImage(data: Data(imageData)) {
                            KFImage(source: .provider(KFImageProvider(image: uiImage)))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 250)
                                .cornerRadius(15)
                        }
                    }

                }
                Spacer()
            }
            
            // Cell bottom
            HStack(spacing: 50) {
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
    }
}

