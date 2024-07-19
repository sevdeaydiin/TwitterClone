//
//  SearchUserCell.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 19.07.2024.
//

import SwiftUI

struct SearchUserCell: View {
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
            VStack (alignment: .leading) {
                Text("sevde")
                    .fontWeight(.heavy)
                Text("@sevdeaydiin")
                    .fontWeight(.thin)
            }
            Spacer(minLength: 0)
        }
    }
}

#Preview {
    SearchUserCell()
}
