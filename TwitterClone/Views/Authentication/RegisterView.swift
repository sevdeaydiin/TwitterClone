//
//  RegisterView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/15/24.
//

import SwiftUI

struct RegisterView: View {
    @State var name = ""
    @State var username = ""
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            NavigationBar()
            Text(LocaleKeys.Register.createAccount.rawValue.locale())
                .font(.title)
                .bold()
                .padding(.top, 35)
            
            VStack(alignment: .leading) {
                RegisterTextField(placeholder: LocaleKeys.Register.name.rawValue.locale(), text: $name)
                RegisterTextField(placeholder: LocaleKeys.Register.username.rawValue.locale(), text: $username)
                RegisterTextField(placeholder: LocaleKeys.Register.email.rawValue.locale(), text: $email)
                RegisterTextField(placeholder: LocaleKeys.Login.password.rawValue.locale(), text: $password)
            }
            Spacer()
            TabbarButton(name: $name, username: $username, email: $email, password: $password)
        }
    }
}

#Preview {
    RegisterView()
}

private struct TabbarButton: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var name: String
    @Binding var username: String
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray)
            HStack {
                Spacer()
                Button {
                    Task {
                        await viewModel.register(name: name, username: username, email: email, password: password)
                    }
                    dismiss()
                } label: {
                    Capsule()
                        .frame(width: 100, height: 30, alignment: .center)
                        .foregroundStyle(.twitterBlue)
                        .overlay(
                            Text(LocaleKeys.Register.register.rawValue.locale())
                                .foregroundStyle(.white)
                        )
                }
            }
            .padding(.trailing, 24)
        }
    }
}
