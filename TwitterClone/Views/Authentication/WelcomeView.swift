//
//  WelcomeView.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/15/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                TwitterLogoView()
                Spacer()
                WelcomeText()
                Spacer()
                
                // Google ve Apple Button
                ContinueButtons()
                PrivacyPolicyText()
            }
            
        }
    }
}

private struct WelcomeText: View {
    var body: some View {
        Text(LocaleKeys.Welcome.welcomeText.rawValue.locale())
            .font(.system(size: FontSizes.large, weight: .heavy, design: .default))
            .frame(width: ViewConstants.width * 0.9, alignment: .center)
    }
}

private struct ContinueButtons: View {
    
    var body: some View {
        VStack (alignment: .center, spacing: 10) {
            ContinueButton(imageText: Images.google, text: LocaleKeys.Welcome.continueGoogle.rawValue.locale())
            ContinueButton(imageText: Images.apple, text: LocaleKeys.Welcome.continueApple.rawValue.locale())
            OrRectangleView()
            CreateAccount()
        }
    }
}

private struct ContinueButton: View {
    
    let imageText: String
    let text: LocalizedStringKey
    
    var body: some View {
        Button {
            
        } label: {
            HStack(spacing: nil, content: {
                Image(imageText)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text(text)
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundStyle(.black)
                    .padding()
            })
            .overlay(RoundedRectangle(cornerRadius: 36).stroke(.black, lineWidth: 1).opacity(0.3).frame(width: 320, height: 60, alignment: .center))
        }
        
    }
}

struct OrRectangleView: View {
    var body: some View {
        HStack {
            Rectangle()
                .foregroundStyle(.gray)
                .opacity(0.3)
                .frame(width: (ViewConstants.width * 0.35), height: 1)
            Text(LocaleKeys.Welcome.or.rawValue.locale())
                .foregroundStyle(.gray)
            Rectangle()
                .foregroundStyle(.gray)
                .opacity(0.3)
                .frame(width: (ViewConstants.width * 0.35), height: 1)
        }
    }
}

private struct CreateAccount: View {
    var body: some View {
        NavigationLink(destination: RegisterView().navigationBarBackButtonHidden()) {
            RoundedRectangle(cornerRadius: 36)
                .foregroundStyle(.twitterBlue)
                .frame(width: 320, height: 60, alignment: .center)
                .overlay(
                    Text(LocaleKeys.Welcome.createAccount.rawValue.locale())
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .font(.title3)
                        .padding()
                )
        }
    }
}

private struct PrivacyPolicyText: View {
    
    let agree = LocaleKeys.Welcome.agree.rawValue.locale()
    let terms = LocaleKeys.Welcome.terms.rawValue.locale()
    let privacyPolicy = LocaleKeys.Welcome.privacyPolicy.rawValue.locale()
    let cookie = LocaleKeys.Welcome.cookie.rawValue.locale()
    let accountAlready = LocaleKeys.Welcome.accountAlready.rawValue.locale()
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text(agree) +
                Text(terms)
                    .foregroundStyle(.twitterBlue) + Text(",") +
                Text(privacyPolicy)
                    .foregroundStyle(.twitterBlue) +
                Text(cookie)
            }
            .padding(.bottom)
            
            HStack(spacing: 2) {
                Text(accountAlready)
                NavigationLink(destination: LoginView().toolbar(.hidden)) {
                    Text(LocaleKeys.Login.login.rawValue.locale())
                        .foregroundStyle(.twitterBlue)
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
