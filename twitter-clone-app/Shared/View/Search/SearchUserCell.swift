//
//  SearchUserCell.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 19.07.2024.
//

import SwiftUI
import Kingfisher

struct SearchUserCell: View {
    
    let user: User
    
    var body: some View {
        HStack {
            KFImage(URL(string: "\(NetworkConstants.baseURL)users/\(self.user.id)/avatar"))
                .placeholder {
                    Image("pp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())
                }
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
            VStack (alignment: .leading) {
                Text(user.name)
                    .fontWeight(.bold)
                Text("@\(user.username)")
                    .fontWeight(.thin)
            }
            .foregroundStyle(.black)
            Spacer(minLength: 0)
        }
    }
}
