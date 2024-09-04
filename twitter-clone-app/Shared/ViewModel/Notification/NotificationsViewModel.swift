//
//  NotificationsCellViewModel.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 4.09.2024.
//

import Foundation

class NotificationsViewModel: ObservableObject {
    
    @Published var notifications = [Notification]()
    let user: User
    
    init(user: User) {
        self.user = user
        fetchNotifications()
    }
    
    func fetchNotifications() {
        RequestServices.requestDomain = "\(NetworkConstants.baseURL)notifications/\(self.user.id)"
        
        RequestServices.fetchData { result in
            switch result {
            case .success(let data):
                guard let notifications = try? JSONDecoder().decode([Notification].self, from: data!) else { return }
                DispatchQueue.main.async {
                    self.notifications = notifications
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
