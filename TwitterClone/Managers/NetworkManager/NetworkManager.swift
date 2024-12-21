//
//  NetworkManager.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/17/24.
//

import Foundation

protocol NetworkService: AnyObject {
    func fetch<T: Decodable>(with endpoint: Endpoint) async throws -> T
}

final class NetworkManager: NetworkService {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    private lazy var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }()
    
    func fetch<T: Decodable>(with endpoint: Endpoint) async throws -> T {
        
        guard let urlRequest = endpoint.createURLRequest() else {
            throw NetworkError.invalidURL
        }
        
        print("NM endpoint: \(urlRequest)")
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Gelen yanıt: \(jsonString)")
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        print("NM httpresponse: \(httpResponse)")
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.failedResponse(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decodedResponse = try jsonDecoder.decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.decodeFailed(errorDescription: error.localizedDescription)
        }
    }
}
