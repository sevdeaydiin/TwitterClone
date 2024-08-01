//
//  ContentView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 15.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.isAuthenticated {
                if let user = viewModel.currentUser {
                    MainView(user: user)
                }
            } else {
                WelcomeView()
            }
        }.onAppear {
            viewModel.isAuthenticated = UserDefaults.standard.object(forKey: "jsonwebtoken") != nil
        }
    }
        
}

#Preview {
    ContentView()
}
