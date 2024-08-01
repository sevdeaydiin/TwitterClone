//
//  WelcomeView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 20.07.2024.
//

import SwiftUI

struct WelcomeView: View {

    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                TwitterLogoView()
                Spacer()
                Text("See what's happening in the world right now.")
                    .font(.system(size: 30, weight: .heavy, design: .default))
                    .frame(width: (getRect().width * 0.9), alignment: .center)
                Spacer()
                VStack(alignment: .center, spacing: 10, content: {
                    
                    Button ( action: {
                        print("Sign in with google")
                    }, label: {
                        HStack(spacing: nil, content: {
                            Image("google")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            
                            Text("Continue with Google")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundStyle(.black)
                                .padding()
                        })
                        .overlay(RoundedRectangle(cornerRadius: 36).stroke(.black, lineWidth: 1).opacity(0.3).frame(width: 320, height: 60, alignment: .center))
                    })
                    
                    Button ( action: {
                        print("Sign in with apple")
                    }, label: {
                        HStack(spacing: nil, content: {
                            Image("apple")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            
                            Text("Continue with Apple")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundStyle(.black)
                                .padding()
                        })
                        .overlay(RoundedRectangle(cornerRadius: 36).stroke(.black, lineWidth: 1).opacity(0.3).frame(width: 320, height: 60, alignment: .center))
                    })
                    
                    
                    OrRectangleView()
                    
                    NavigationLink(destination: RegisterView().toolbar(.hidden)) {
                        RoundedRectangle(cornerRadius: 36)
                            .foregroundStyle(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                            .frame(width: 320, height: 60, alignment: .center)
                            .overlay(
                                Text("Create account")
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .padding()
                            )
                    }
                })
                .padding()
                
                VStack( alignment: .leading, content: {
                    VStack {
                        Text("By signing up, you agree to our ")
                        + Text("Terms")
                            .foregroundStyle(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255)) + Text(",") +
                        Text("Privacy Policiy")
                            .foregroundStyle(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255)) +
                        Text(", and Cookie Use.")
                    }
                    .padding(.bottom)
                    
                    HStack(spacing: 2) {
                        Text("Have an account already? ")
                        NavigationLink(destination: LoginView().toolbar(.hidden)) {
                            Text("Log in")
                                .foregroundStyle(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                        }
                    }
                })
                
            }
            .toolbar(.hidden)
            .navigationTitle("")
        }
    }
}

struct TwitterLogoView: View {
    var body: some View {
        HStack {
            Spacer()
            Image("Twitter")
                .resizable()
                .scaledToFill()
                .padding(.trailing)
                .frame(width: 20, height: 20)
            Spacer()
        }
    }
}

struct OrRectangleView: View {
    var body: some View {
        HStack {
            Rectangle()
                .foregroundStyle(.gray)
                .opacity(Stable.opacitiy)
                .frame(width: (getRect().width * 0.35), height: 1)
            Text("Or")
                .foregroundStyle(.gray)
            Rectangle()
                .foregroundStyle(.gray)
                .opacity(Stable.opacitiy)
                .frame(width: (getRect().width * 0.35), height: 1)
        }
    }
}

#Preview {
    WelcomeView()
}
