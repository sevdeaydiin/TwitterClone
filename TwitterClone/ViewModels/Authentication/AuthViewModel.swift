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
    
    private let authManager: AuthManagerProtocol
    private let defaults: UserDefaults
    private var cancellables = Set<AnyCancellable>()
    private var currentFetchTask: Task<Void, Never>?

    init(authManager: AuthManagerProtocol, defaults: UserDefaults = .standard) {
        self.authManager = authManager
        self.defaults = defaults
        initializeAuthenticationState()
    }

    deinit {
        print("AuthViewModel deinit çağrıldı")
    }

    private func initializeAuthenticationState() {
        if let token = defaults.string(forKey: "jsonwebtoken"), let userId = defaults.string(forKey: "userId") {
            self.isAuthenticated = true
            print("Stored Token: \(token)")
            print("Stored UserID: \(userId)")
            Task {
                await fetchUser(userId: userId)
            }
        }
    }

    func login(email: String, password: String) async {
        print("AuthViewModel.login başladı. Email: \(email)")
        self.viewState = .loading
        errorMessage = nil
        
        do {
            let response = try await authManager.login(email: email, password: password)
            print(response)
            saveAuthenticationData(response: response)
            self.viewState = .showData
        } catch let error as NetworkError {
            handleError(error: error)
        } catch {
            handleError(error: NetworkError.unknownError)
        }
        
        //print("AuthViewModel.login bitti. isAuthenticated: \(isAuthenticated)")
    }

    func register(name: String, username: String, email: String, password: String) async {
        self.viewState = .loading
        
        do {
            _ = try await authManager.register(username: username, email: email, password: password)
            self.viewState = .showData
        } catch let error as NetworkError {
            handleError(error: error)
        } catch {
            handleError(error: NetworkError.unknownError)
        }
    }

    func fetchUser(userId: String) async {
        self.viewState = .loading
        
        do {
            let user = try await authManager.fetchUser(userId: userId)
            self.currentUser = user.user
            self.isAuthenticated = true
            self.viewState = .showData
        } catch let error as NetworkError {
            handleError(error: error)
        } catch {
            handleError(error: NetworkError.unknownError)
        }
    }

    func logout() {
        clearAuthenticationData()
    }

    private func saveAuthenticationData(response: ApiResponse) {
        defaults.set(response.token, forKey: "jsonwebtoken")
        defaults.set(response.user.id, forKey: "userId")
        self.currentUser = response.user
        self.isAuthenticated = true
    }

    private func clearAuthenticationData() {
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
