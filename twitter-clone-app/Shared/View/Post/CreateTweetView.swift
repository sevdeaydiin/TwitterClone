//
//  CreateTweetView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 16.07.2024.
//

import SwiftUI

struct CreateTweetView: View {
    
    @Binding var show: Bool
    @State var text = ""
    @ObservedObject var viewModel = CreateTweetViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.show.toggle()
                }label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button {
                    if text != "" {
                        self.viewModel.uploadPost(text: text)
                        self.show.toggle()
                    }
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
