//
//  MenuButton.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 19.07.2024.
//

import SwiftUI

struct MenuButton: View {
    
    var title: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(title)
                .resizable()
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundStyle(.gray)
            Text(title)
                .foregroundStyle(.black)
            Spacer()
        }.padding(.vertical, 12)
    }
}

#Preview {
    MenuButton(title: "logo")
}
