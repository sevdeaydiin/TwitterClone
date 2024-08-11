//
//  AuthServices.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 22.07.2024.
//

import Foundation
import SwiftUI

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

public class AuthServices {
    
    public static var requestDomain = ""
    
    static func login(email: String, password: String, completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void) {
        let urlString = URL(string: "\(NetworkConstants.baseURL)users/login")!
        
        makeRequest(urlString: urlString, reqBody: ["email": email, "password": password]) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(.invalidCredentials))
            }
        }
    }
    
    static func register(email: String, username: String, password: String, name: String, completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void) {
        let urlString = URL(string: "\(NetworkConstants.baseURL)users")!
        
        makeRequest(urlString: urlString, reqBody: ["email": email, "username": username, "name": name, "password": password]) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(.invalidCredentials))
                
            }
        }
    }
    
    static func makeRequest(urlString: URL, reqBody: [String: Any], completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        
        let session = URLSession.shared
        
        var request = URLRequest(url: urlString)
        
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
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                }
            } catch let error {
                completion(.failure(.decodingError))
                print(error)
            }
        }
            
        task.resume()
    }
    
    // Fetch user func
    static func fetchUser(id: String, completion: @escaping (_ result: Result<Data, AuthenticationError>) -> Void) {
        
        let urlString = URL(string: "\(NetworkConstants.baseURL)users/\(id)")!
        var urlRequest = URLRequest(url: urlString)
        
        let session = URLSession.shared
        
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: urlRequest) { data, res, err in
            if let err = err {
                completion(.failure(.custom(errorMessage: err.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.custom(errorMessage: "no data")))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
    
    static func makePatchRequestWithAuth(urlString: URL, reqBody: [String: Any], completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        
        let session = URLSession.shared
        
        var request = URLRequest(url: urlString)
        request.httpMethod = "PATCH"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted)
        }
        catch let error {
            print("Error serializing JSON:", error)
                    completion(.failure(.decodingError))
                    return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "jsonwebtoken") else {
            print("No token found")
            completion(.failure(.noData))
            return
        }
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = session.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Request error:", err.localizedDescription)
                completion(.failure(.decodingError))
                return
            }
            guard let data = data else {
                print("No data returned")
                completion(.failure(.noData))
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("Response JSON:", json)
                    if let errorMessage = json["error"] as? String {
                        completion(.failure(.decodingError))
                        print("Error from server:", errorMessage)
                        return
                    }
                }
                completion(.success(data))
            } catch let error {
                completion(.failure(.decodingError))
                print("Decoding error:", error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
