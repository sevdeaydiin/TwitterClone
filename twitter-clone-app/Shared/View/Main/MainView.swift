//
//  MainView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 19.07.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            TopBar()
            Home(selectedIndex: 0)
        }
    }
}

#Preview {
    MainView()
}
