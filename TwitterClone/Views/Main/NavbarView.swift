//
//  NavbarView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/29/24.
//

import SwiftUI
import Kingfisher

struct NavbarView: View {
    @Binding var x: CGFloat
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            HStack {
                if let user = viewModel.currentUser {
                    Button {
                        withAnimation {
                            x = 0
                        }
                    } label: {
                        KFImage(URL(string: "\(K.baseURL)users/\(user.id)/avatar"))
                            .placeholder {
                                Image(systemName: "person")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .clipShape(Circle())
                            }
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
    //                        .font(.system(size: 24))
    //                        .foregroundStyle(.twitterBlue)
                    }
                }

                Spacer(minLength: 0)
                
                Image(Images.twitter)
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

