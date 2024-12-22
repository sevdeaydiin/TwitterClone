//
//  TweetCellView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/21/24.
//

import SwiftUI
import Kingfisher

struct TweetCellView: View {
    //let tweet: Tweet
    @ObservedObject var viewModel: TweetViewModel
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 10) {
                KFImage(URL(string: "localhost:3000/users/66f079b9a02ee59b751ea757/avatar"))
                    .placeholder {
                        PlaceholderView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                
                
                ///
                VStack(alignment: .leading, spacing: 6) {
                    
                }
            }
        }
    }
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
