//
//  LoginView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/15/24.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = "sevde.aydn@gmail.com"
    @State var password = "123456789"
    @State var emailDone = false
    
    var body: some View {
        if !emailDone {
            EmailView(email: $email, emailDone: $emailDone)
        } else {
            PasswordView(email: $email, password: $password, emailDone: $emailDone)
        }
    }
}

private struct EmailView: View {
    
    @Binding var email: String
    @Binding var emailDone: Bool
    
    var body: some View {
        VStack {
            VStack {
                NavigationBar()
                LoginText(text: LocaleKeys.Login.emailText.rawValue.locale())
                AuthTextField(placeholder: LocaleKeys.Login.email.rawValue.locale(), email: $email)
            }
            Spacer()
            LoginButton(buttonText: LocaleKeys.General.next.rawValue.locale(), action: {
                if !email.isEmpty {
                    self.emailDone.toggle()
                }
            })
        }
    }
}

private struct PasswordView: View {

    @Binding var email: String
    @Binding var password: String
    @Binding var emailDone: Bool
    
    var body: some View {
        VStack {
            VStack {
                NavigationBar()
                LoginText(text: LocaleKeys.Login.password.rawValue.locale())
                SecureAuthTextField(placeholder: LocaleKeys.Login.passwordPlaceholder.rawValue.locale(), password: $password)
            }
            Spacer()
            LoginButton(buttonText: LocaleKeys.Login.login.rawValue.locale(), action: {
                
            })
        }
    }
}

#Preview {
    LoginView()
}

private struct NavigationBar: View {
    var body: some View {
        ZStack {
            HStack {
                CancelButton()
                Spacer()
            }
            .padding()
            
            Image(Images.twitter)
                .resizable()
                .scaledToFill()
                .padding(.trailing)
                .frame(width: 20, height: 20)
        }
    }
}

private struct LoginText: View {
    let text: LocalizedStringKey
    var body: some View {
        Text(text)
            .font(.title2)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .padding(.top)
    }
}

private struct LoginButton: View {
    
    let buttonText: LocalizedStringKey
    var action: (() -> Void)
    
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                Capsule()
                    .frame(width: 360, height: 40, alignment: .center)
                    .foregroundStyle(.twitterBlue)
                    .overlay {
                        Text(buttonText)
                            .foregroundStyle(.white)
                    }
            }
            .padding(.bottom, 4)
            Text(LocaleKeys.Login.forgotPassword.rawValue.locale())
                .foregroundStyle(.twitterBlue)
        }
    }
}
