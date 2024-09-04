//
//  NotificationsView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 15.07.2024.
//

import SwiftUI

struct NotificationsView: View {
    
    let user: User
    @ObservedObject var viewModel: NotificationsViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = NotificationsViewModel(user: user)
    }
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            LazyVStack {
                ForEach(viewModel.notifications) { not in
                    NotificationCell(notification: not)
                }
            }
        }
    }
}
