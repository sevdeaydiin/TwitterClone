//
//  LoginView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 22.07.2024.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = "sevde.aydn@gmail.com"
    @State var password = "123456789"
    @State var emailDone = false
    @EnvironmentObject var viewModel: AuthViewModel
    //let user: User?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        if !emailDone {
            EmailView(email: $email, emailDone: $emailDone)
        }
        
        else {
            PasswordView(email: $email, password: $password, emailDone: $emailDone)
        }
    }
}

struct EmailView: View {
    
    @Binding var email: String
    @Binding var emailDone: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    HStack {
                        Button(action: {
                            dismiss()
                        },
                               label: {
                            Text("Cancel")
                                .foregroundStyle(.blue)
                        })
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Image("Twitter")
                        .resizable()
                        .scaledToFill()
                        .padding(.trailing)
                        .frame(width: 20, height: 20)
                }
                
                Text("To get started first enter your phone, email or @username")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top)
                
                CustomAuthTextField(placeholder: "Phone, email or username", text: $email)
            }
            Spacer()
            
            VStack {
                Button(action: {
                    if !email.isEmpty {
                        self.emailDone.toggle()
                    }
                }, label: {
                    Capsule()
                        .frame(width: 360, height: 40, alignment: .center)
                        .foregroundStyle(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                        .overlay {
                            Text("Next")
                                .foregroundStyle(.white)
                        }
                })
                .padding(.bottom, 4)
                Text("Forgot password?")
                    .foregroundStyle(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
            }
        }
    }
}

struct PasswordView: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var emailDone: Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    
                    HStack {
                        Button(action: {
                            dismiss()
                        },
                               label: {
                            Text("Cancel")
                                .foregroundStyle(.blue)
                        })
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Image("Twitter")
                        .resizable()
                        .scaledToFill()
                        .padding(.trailing)
                        .frame(width: 20, height: 20)
                }
                
                Text("Enter your password")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top)
                
                SecureAuthTextField(placeholder: "Passoword", text: $password)
            }
            Spacer()
            
            VStack {
                    Button(action: {
                        print(email)
                        print(password)
                        self.viewModel.login(email: email, password: password)
                        //emailDone.toggle()
                    }, label: {
                        Capsule()
                            .frame(width: 360, height: 40, alignment: .center)
                            .foregroundStyle(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                            .overlay {
                                Text("Log in")
                                    .foregroundStyle(.white)
                            }
                    })
                    .padding(.bottom, 4)
    
                Text("Forgot password?")
                    .foregroundStyle(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
            }
        }
    }
}
