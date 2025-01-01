//
//  SlideMenu.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 1/1/25.
//

import SwiftUI
import Kingfisher

struct SlideMenu: View {
    @EnvironmentObject var viewModel: AuthViewModel
    //@Binding var isUserProfileActive: Bool
    @State var show = true
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    if let user = viewModel.currentUser {
                        NavigationLink(destination: ProfileView()) {
                            KFImage(URL(string: "\(K.baseURL)users/\(user.id)/avatar"))
                                .placeholder{
                                    Image(systemName: "person")
                                        .resizable()
                                    //.aspectRatio(contentMode: .fill)
                                        .frame(width: 75, height: 75)
                                        .clipShape(Circle())
                                }
                                .resizable()
                                .frame(width: 60, height: 60, alignment: .center)
                                .clipShape(Circle())
                        }
                    }
                    UserInfo()
                    
                    
                    Divider()
                        .padding(.top, 10)
                
                }
                Spacer()
                Button {
                    self.show.toggle()
                } label: {
                    Image(systemName: show ? "chevron.down" : "chevron.up")
                        .foregroundStyle(.text)
                }
                
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

private struct UserInfo: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading) {
                if let user = viewModel.currentUser {
                    NavigationLink(destination: ProfileView()) {
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
}

#Preview {
    SlideMenu()
}
