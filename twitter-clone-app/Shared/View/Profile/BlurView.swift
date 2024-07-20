//
//  BlurView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 20.07.2024.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
