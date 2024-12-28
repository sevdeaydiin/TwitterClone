//
//  AuthenticationViewModel.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/17/24.
//

import Foundation

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
    
    private let authManager: AuthService

    init(authManager: AuthService) {
        self.authManager = authManager
        //logout()
        initializeAuthenticationState()
    }

    deinit {
        print("AuthViewModel deinit çağrıldı")
    }

    private func initializeAuthenticationState() {
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: "jsonwebtoken")
        if token != nil {
            isAuthenticated = true
            if let userId = defaults.object(forKey: "userId") as? String {
                //self.isAuthenticated = true
                print("Stored Token: \(String(describing: token))")
                print("Stored UserID: \(userId)")
                Task {
                    await fetchUser(userId: userId)
                }
            }
        }
    }

    func login(email: String, password: String) async {
        self.viewState = .loading
        errorMessage = nil
        
        do {
            let response = try await authManager.login(email: email, password: password)
            saveAuthenticationData(response: response)
            self.viewState = .showData
        } catch let error as NetworkError {
            handleError(error: error)
        } catch {
            handleError(error: NetworkError.unknown)
        }
    }

    func register(name: String, username: String, email: String, password: String) async {
        self.viewState = .loading
        
        do {
            _ = try await authManager.register(name: name, username: username, email: email, password: password)
            self.viewState = .showData
        } catch let error as NetworkError {
            handleError(error: error)
        } catch {
            handleError(error: NetworkError.unknown)
        }
    }

    func fetchUser(userId: String) async {
        self.viewState = .loading
        
        do {
            let user = try await authManager.fetchUser(userId: userId)
            self.currentUser = user
            self.isAuthenticated = true
            self.viewState = .showData
        } catch let error as NetworkError {
            handleError(error: error)
        } catch {
            handleError(error: NetworkError.unknown)
        }
    }

    func logout() {
        clearAuthenticationData()
    }

    private func saveAuthenticationData(response: ApiResponse) {
        let defaults = UserDefaults.standard
        defaults.set(response.token, forKey: "jsonwebtoken")
        defaults.set(response.user.id, forKey: "userId")
        self.currentUser = response.user
        self.isAuthenticated = true
    }

    private func clearAuthenticationData() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jsonwebtoken")
        defaults.removeObject(forKey: "userId")
        self.currentUser = nil
        self.isAuthenticated = false
    }

    private func handleError(error: NetworkError) {
        self.viewState = .error(error.localizedDescription)
        self.errorMessage = error.localizedDescription
        print(error.localizedDescription)
        self.isAuthenticated = false
    }
}
