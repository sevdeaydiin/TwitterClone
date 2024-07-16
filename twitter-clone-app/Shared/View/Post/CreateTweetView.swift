//
//  CreateTweetView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 16.07.2024.
//

import SwiftUI

struct CreateTweetView: View {
    
    @State var text = ""
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                }label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button {
                    
                }label: {
                    Text("Tweet")
                        .padding()
                }
                .background(Color.bg)
                .foregroundStyle(.white)
                .clipShape(Capsule())
            }
            
            MultilineTextField(text: $text)
            //TextField("What's happening?", text: $text)
            
        }.padding()
    }
}

#Preview {
    CreateTweetView()
}
