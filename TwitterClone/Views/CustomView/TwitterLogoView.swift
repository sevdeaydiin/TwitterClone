//
//  TwitterLogoView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/15/24.
//

import SwiftUI

struct TwitterLogoView: View {
    var body: some View {
        HStack {
            Spacer()
            Image(Images.twitter)
                .resizable()
                .scaledToFill()
                .padding(.trailing)
                .frame(width: 40, height: 40)
            Spacer()
        }
    }
}

#Preview {
    TwitterLogoView()
}
