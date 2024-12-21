//
//  AuthenticationViewModel.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/17/24.
//

import Foundation
import Combine

enum ViewState: Equatable {
    case idle
    case loading
    case noData
    case showData
    case error(String)
}

@MainActor
final class AuthViewModel: ObservableObject {
    @Published private(set) var viewState: ViewState = .idle
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    
    private let authManager: AuthServiceProtocol
    private let defaults: UserDefaults
    //private let cacheManager: CacheService
    
    private var cancellables = Set<AnyCancellable>()
    private var currentFetchTask: Task<Void, Never>?
    //static let shared = AuthViewModel(authService: AuthManager(networkService: NetworkManager()), cacheManager: CacheManager())
    
    init(authManager: AuthServiceProtocol, defaults: UserDefaults = .standard //cacheManager: CacheService
    ) {
        self.authManager = authManager
        self.defaults = defaults
        //self.cacheManager = cacheManager
        print("Token: \(defaults.string(forKey: "jsonwebtoken") ?? "Yok")")
        print("UserID: \(defaults.string(forKey: "userId") ?? "Yok")")
        
        if let _ = defaults.string(forKey: "jsonwebtoken"), let userId = defaults.string(forKey: "userId") {
            self.isAuthenticated = true
            Task {
                await fetchUser(userId: userId)
            }
        }
    }
    
    deinit {
        print("AuthViewModel deinit çağrıldı")
    }
    
    func login(email: String, password: String) async {
        print("AuthViewModel.login başladı. Email: \(email), Şifre: \(password)")
        self.viewState = .loading
        errorMessage = nil
        
        do {
            let response = try await authManager.login(email: email, password: password)
            print("view model response: \(response)")
            defaults.set(response.token, forKey: "jsonwebtoken")
            defaults.set(response.user.id, forKey: "userId")
            self.currentUser = response.user
            self.isAuthenticated = true
            print("current user: \(self.currentUser)")
            self.viewState = .showData
        } catch let networkError as NetworkError {
            self.viewState = .error(networkError.localizedDescription)
            self.isAuthenticated = false
        } catch {
            self.isAuthenticated = false
            self.viewState = .error("Bilinmeyen bir hata oluştu: \(error.localizedDescription)")
        }
        print("AuthViewModel.login bitti. isAuthenticated: \(isAuthenticated)")
    }
    
    func register(name: String, username: String, email: String, password: String) async {
        self.viewState = .loading
        do {
            _ = try await authManager.register(username: username, email: email, password: password)
            self.viewState = .showData
        } catch {
            if let error = error as? NetworkError {
                self.viewState = .error(error.localizedDescription)
            }
        }
    }
    
    func fetchUser(userId: String) async {
        self.viewState = .loading
        do {
            let user = try await authManager.fetchUser(userId: userId)
            self.currentUser = user.user
            self.isAuthenticated = true
            self.viewState = .showData
        } catch {
            if let error = error as? NetworkError {
                self.viewState = .error(error.localizedDescription)
            }
        }
    }
    
    func logout() {
            self.currentUser = nil
            self.isAuthenticated = false
        }

}
