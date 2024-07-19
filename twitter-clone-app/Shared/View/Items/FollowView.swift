//
//  FollowView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 19.07.2024.
//

import SwiftUI

struct FollowView: View {
    var count: Int
    var title: String
    var body: some View {
        HStack {
            Text("\(count)")
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            
            Text(title)
                .foregroundStyle(.gray)
        }
    }
}
