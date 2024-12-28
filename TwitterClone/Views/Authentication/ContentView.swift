//
//  ContentView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/20/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        if authViewModel.isAuthenticated {
            if let user = authViewModel.currentUser {
                MainView(user: user)
            }
        } else {
            WelcomeView()
        }
    }
}

#Preview {
    ContentView()
}
