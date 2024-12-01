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
    
    var didLike: Bool { return viewModel.tweet.didLike ?? false }
    
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
                    
                    if let name = self.viewModel.user?.name {
                        
                        if let username = self.viewModel.user?.username {
                            Text(name)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                            +
                            Text(" @\(username)")
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    
                    Text(self.viewModel.tweet.text)
                        .frame(maxHeight: 100, alignment: .top)
                    
                    if let imageData = viewModel.tweet.image?.data {
                        if let uiImage = UIImage(data: Data(imageData)) {
                            KFImage(source: .provider(KFImageProvider(image: uiImage)))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: (Sizes.width / 2) + Sizes.width / 4, height: 250)
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
                    if(self.didLike) {
                        self.viewModel.unlike()
                    } else {
                        self.viewModel.like()
                    }
                } label: {
                    
                    if(self.didLike == false) {
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 18, height: 15)
                    } else {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(.pink)
                            .frame(width: 18, height: 15)
                    }
                    
                }.foregroundStyle(.gray)
                
                HStack(spacing: 20) {
                    Button {
                        
                    } label: {
                        Image(systemName: "bookmark")
                            .resizable()
                            .frame(width: 14, height: 14)
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

