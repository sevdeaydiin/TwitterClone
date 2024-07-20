//
//  AuthViewModel.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 21.07.2024.
//

import SwiftUI

class AuthViewModel: ObservableObject {
     
    func login() {
        
    }
    
    func register(reqBody: [String: Any]) {
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "http://localhost:3000/users")!)
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted)
        } catch let error {
            print(error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else { return }
            guard let data = data else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                }
            } catch let error {
                print(error)
            }
        }
            
        task.resume()
        
    }
    
    func logout() {
        
    }
    
}
