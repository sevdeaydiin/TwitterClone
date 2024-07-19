//
//  NotificationsView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 15.07.2024.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        ScrollView (showsIndicators: false) {
            LazyVStack {
                ForEach(0..<15) { not in
                    NotificationCell()
                }
            }
        }
    }
}

#Preview {
    NotificationsView()
}
