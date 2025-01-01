//
//  SlideMenu.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 1/1/25.
//

import SwiftUI
import Kingfisher

struct SlideMenu: View {
    @ObservedObject var viewModel: AuthViewModel
    //@Binding var isUserProfileActive: Bool
    @State var show = true
    
    var body: some View {
        if let user = viewModel.currentUser {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        NavigationLink(destination: UserProfile()) {
                            KFImage(URL(string: "\(K.baseURL)users/\(user.id)/avatar"))
                                .placeholder{
                                    Image(systemName: "person")
                                        .resizable()
                                        .frame(width: 75, height: 75)
                                        .clipShape(Circle())
                                }
                                .resizable()
                                .frame(width: 60, height: 60, alignment: .center)
                                .clipShape(Circle())
                        }
                        
                        UserInfo(user: user)
                        
                        
                        Divider()
                            .padding(.top, 10)
                        
                    }
                    Spacer()
                    
                    
                }
                
                VStack(alignment: .leading) {
                    Button {
                        viewModel.logout()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                    }
                }
            }
        }
    }
}

private struct UserInfo: View {
    let user: User
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading) {
                NavigationLink(destination: UserProfile()) {
                    Text(user.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }
                Text("@\(user.username)")
                
            }
        }
    }
}

