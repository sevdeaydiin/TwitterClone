//
//  NavbarView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/29/24.
//

import SwiftUI

struct NavbarView: View {
    @Binding var x: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        x = 0
                    }
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 24))
                        .foregroundStyle(.twitterBlue)
                }
                
                Spacer(minLength: 0)
                
                Image("twitter")
                    .resizable()
                    .scaledToFill()
                    .padding(.trailing)
                    .frame(width: 20, height: 20)
                Spacer()
            }
            .padding()
            
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 1, alignment: .leading)
                .foregroundStyle(.gray)
                .opacity(0.3)
        }
    }
}

