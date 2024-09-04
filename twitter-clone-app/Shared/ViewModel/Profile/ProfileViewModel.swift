//
//  ProfileViewModel.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 10.08.2024.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var user: User
    @Published var tweets = [Tweet]()
    
    init(user: User) {
        self.user = user
        fetchTweets()
        checkIsCurrentUser()
        checkUserFollow()
    }
    
    func fetchTweets() {
        RequestServices.requestDomain = "\(NetworkConstants.baseURL)tweets/\(self.user.id)"
        
        RequestServices.fetchData { result in
            switch result {
            case .success(let data):
                guard let tweets = try? JSONDecoder().decode([Tweet].self, from: data!) else { return }
                DispatchQueue.main.async {
                    self.tweets = tweets
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // Check If User Is Current User
    func checkIsCurrentUser() {
        if(self.user._id == AuthViewModel.shared.currentUser?._id) {
            self.user.isCurrentUser = true
        }
    }
    
    func follow() {
        
        guard let authedUser = AuthViewModel.shared.currentUser else { return }
        
        RequestServices.requestDomain = "\(NetworkConstants.baseURL)users/\(self.user.id)/follow"
        
        RequestServices.followingProcess(id: self.user.id) { result in
            print(result)
        }
        
        RequestServices.requestDomain = "\(NetworkConstants.baseURL)notifications"
        RequestServices.sendNotification(username: authedUser.username, notSenderId: authedUser.id, notReceiverId: self.user.id, notificationType: NotificationType.follow.rawValue, postText: "") { result in
            print("followed")
        }
        self.user.isFollow = true
    }
    
    func unfollow() {
        RequestServices.requestDomain = "\(NetworkConstants.baseURL)users/\(self.user.id)/unfollow"
        
        RequestServices.followingProcess(id: self.user.id) { result in
            
        }
        self.user.isFollow = false
    }
    
    // check if user is followed
    func checkUserFollow() {
        if(self.user.followers!.contains(AuthViewModel.shared.currentUser!._id)) {
            self.user.isFollow = true
        } else {
            self.user.isFollow = false
        }
    }
    
}
