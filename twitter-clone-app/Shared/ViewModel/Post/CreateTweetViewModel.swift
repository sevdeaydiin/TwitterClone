//
//  CreateTweetViewModel.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 1.08.2024.
//

import SwiftUI

class CreateTweetViewModel: ObservableObject {
    
    func uploadPost(text: String, image: UIImage?) {
        
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        RequestServices.requestDomain = "\(NetworkConstants.baseURL)tweets"
        
        RequestServices.postTweet(text: text, user: user.name, username: user.username, userId: user.id) { result in
            if let result = result, let id = result["_id"] as? String {
                if let image = image {
                    ImageUploader.uploadImage(paramName: "upload", fileName: "image1", image: image, urlPath: "/uploadTweetImage/\(id)")
                }
            }
        }
        
    }
}
