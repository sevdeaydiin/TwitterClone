//
//  ImageUploader.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 4.08.2024.
//

import Foundation
import SwiftUI

struct ImageUploader {
    
    static func uploadImage(paramName: String, fileName: String, image: UIImage, urlPath: String) {
        
        guard let url = URL(string: "http://localhost:3000\(urlPath)") else { return }
        
        let boundary = UUID().uuidString
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 120
        let session = URLSession(configuration: sessionConfig)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        // authentication
        guard let token = UserDefaults.standard.string(forKey: "jsonwebtoken") else {
            print("No token found")
            return
        }
        
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)
        
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        session.uploadTask(with: urlRequest, from: data) { responseData, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let responseData = responseData else {
                print("No response data")
                return
            }
            
            do {
                // Parse JSON response
                if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                    print("Response JSON: \(json)")
                } else {
                    print("Invalid JSON response")
                }
            } catch {
                print("Error parsing response data: \(error.localizedDescription)")
            }
        }.resume()
    }
}

