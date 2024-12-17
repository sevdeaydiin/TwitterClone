//
//  CancelButton.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/15/24.
//

import SwiftUI

struct CancelButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Text(LocaleKeys.General.cancel.rawValue.locale())
                .foregroundStyle(.twitterBlue)
        }

    }
}
