//
//  SearchCell.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 19.07.2024.
//

import SwiftUI

struct SearchCell: View {
    
    var tag = ""
    var tweets = ""
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5) {
            Text("hello")
                .fontWeight(.semibold)
            Text(tweets + " tweets")
                .fontWeight(.light)
        }
    }
}

#Preview {
    SearchCell()
}
