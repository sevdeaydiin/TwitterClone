//
//  TopBar.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 19.07.2024.
//

import SwiftUI

struct TopBar: View {
    
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
                        .foregroundStyle(.twitter)
                }
                
                Spacer(minLength: 0)
                
                Image("Twitter")
                    .resizable()
                    .scaledToFill()
                    .padding(.trailing)
                    .frame(width: 20, height: 20)
                Spacer()
            }
            .padding()
            
            Rectangle()
                .frame(width: Sizes.width, height: 1, alignment: .leading)
                .foregroundStyle(.gray)
                .opacity(Stable.opacitiy)
        }
    }
}

