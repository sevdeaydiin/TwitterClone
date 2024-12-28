//
//  MainView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/21/24.
//

import SwiftUI

struct MainView: View {
    let user: User
    var body: some View {
        Text(user.name)
    }
}

#Preview {
    MainView(user: User.mockData)
}
