//
//  MessageCell.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 19.07.2024.
//

import SwiftUI

struct MessageCell: View {
     
    let width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack (alignment: .leading, spacing: nil) {
            //Rectangle()
            //    .frame(width: width, height: 1, alignment: .center)
            //    .foregroundStyle(.gray)
            //    .opacity(0.3)
            
            HStack (spacing: 15) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
                    .padding(.leading)
                
                VStack (alignment: .leading, spacing: 5){
                    HStack {
                        Text("Sevde ")
                            .fontWeight(.regular)
                            .foregroundStyle(.primary)
                        
                        Text ("@sevdeaydiin")
                            .foregroundStyle(.gray)
                        Spacer()
                        Text("24.06.2024")
                            .foregroundStyle(.gray)
                    }
                    
                        Text("You: Hey you, whats up?")
                        .fontWeight(.light)
                        .font(.subheadline)
                        .opacity(0.6)
                    
                }
            }
        }
        .padding(.bottom, 15)
        .padding(.trailing, 10)
    }
}

#Preview {
    MessageCell()
}
