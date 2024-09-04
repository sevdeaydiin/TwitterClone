//
//  NotificationCell.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 19.07.2024.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    
    let notification: Notification
    
    var body: some View {
        VStack {
            HStack (alignment: .top, spacing: 10) {
                
                Image(systemName: "person.fill")
                    .resizable()
                    .foregroundStyle(.blue)
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(.top, 5)
                
                VStack (alignment: .leading, spacing: 5){
                    KFImage(URL(string: "\(NetworkConstants.baseURL)users/\(notification.notSenderId)/avatar"))
                        .placeholder {
                            Image("pp")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                        }
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .cornerRadius(18)
                    
                    //if let name = notification.username {
                    Text("\(notification.username) ")
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    +
                    Text(notification.notificationType.rawValue == "follow" ? NotificationType.follow.notificationMessage : NotificationType.like.notificationMessage)
                        .foregroundStyle(.black)
                    //}
                    
                }
                Spacer()
            }.padding(.leading, 30)
            Rectangle()
                .frame(width: Sizes.width, height: 1, alignment: .center)
                .foregroundStyle(.gray)
                .opacity(Stable.opacitiy)
        }
    }
}

