//
//  AuthViewModel.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 21.07.2024.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    
    init() {
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: "jsonwebtoken")
        //defaults.removeObject(forKey: "jsonweboken")
        
        if token != nil {
            isAuthenticated = true
             
            if let userId = defaults.object(forKey: "userid") {
                fetchUser(userId: userId as! String)
                print("User fetched")
            }
        } else {
            isAuthenticated = false
        }
    }
    
    static let shared = AuthViewModel()
     
    func login(email: String, password: String) {
        
        let defaults = UserDefaults.standard
        
        AuthServices.login(email: email, password: password) { result in
            switch result {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data!) else { return }
                DispatchQueue.main.async {
                    defaults.set(user.token, forKey: "jsonwebtoken")
                    defaults.set(user.user.id, forKey: "userid")
                    self.isAuthenticated = true
                    self.currentUser = user.user
                    print("logged in")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func register(name: String, username: String, email: String, password: String) {
        
        AuthServices.register(email: email, username: username, password: password, name: name) { result in
            switch result {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data!) else {
                    return
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchUser(userId: String) {
        AuthServices.fetchUser(id: userId) { result in
            switch result {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(User.self, from: data) else { return }
                
                DispatchQueue.main.async {
                    UserDefaults.standard.setValue(user.id, forKey: "userid")
                    self.isAuthenticated = true
                    self.currentUser = user
                    print(user)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func logout() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
    
}
