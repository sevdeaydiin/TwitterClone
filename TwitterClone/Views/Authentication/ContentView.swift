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
        NavigationView {
            Group {
                if authViewModel.isAuthenticated {
                    FeedView()
                } else {
                    WelcomeView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
