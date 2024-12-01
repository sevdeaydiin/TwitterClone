//
//  SearchViewModel.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 3.09.2024.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers(){
        
        AuthServices.requestDomain = "http://localhost:3000/users"
        
        AuthServices.fetchUser { [weak self] result in
            switch result {
            case .success(let data):
                guard let users = try? JSONDecoder().decode([User].self, from: data) else { return }
                DispatchQueue.main.async {
                    self?.users = users
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter({ $0.name.lowercased().contains(lowercasedQuery) || $0.username.lowercased().contains(lowercasedQuery) })
    }
    
}
