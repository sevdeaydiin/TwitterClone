//
//  LocaleKeys.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/15/24.
//

import Foundation
import SwiftUI

struct LocaleKeys {
    
    enum Welcome: String {
        case welcomeText = "welcomeText"
        case signInGoogle = "signInGoogle"
        case continueGoogle = "continueGoogle"
        case signInApple = "signInApple"
        case continueApple = "continueApple"
        case createAccount = "createAccount"
        case agree = "agree"
        case terms = "terms"
        case privacyPolicy = "privacyPolicy"
        case cookie = "cookie"
        case accountAlready = "accountAlready"
        case or = "or"
    }
    
    enum Login: String {
        case login = "login"
        case email = "email"
        case emailText = "emailText"
        case password = "password"
        case forgotPassword = "forgotPassword"
        case passwordPlaceholder = "passwordPlaceholder"
    }
    
    enum General: String {
        case cancel = "cancel"
        case next = "next"
    }
}

extension String {
    func locale() -> LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}
