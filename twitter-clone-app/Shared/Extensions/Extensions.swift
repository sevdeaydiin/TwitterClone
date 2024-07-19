//
//  Extensions.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 19.07.2024.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
