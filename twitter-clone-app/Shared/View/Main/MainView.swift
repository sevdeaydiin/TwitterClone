//
//  MainView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 19.07.2024.
//

import SwiftUI

struct MainView: View {
    
    @State var width = Sizes.width - 90
    @State var x = -Sizes.width + 90
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                    VStack {
                        TopBar(x: $x)
                        Home(selectedIndex: 0)
                    }
                    .overlay(
                        Color.black.opacity(x == 0 ? 0.5 : 0)
                    )
                    
                    SlideMenu()
                        .shadow(color: .black.opacity(x != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                        .offset(x: x)
                    //.background(.black.opacity(x == 0 ? 0.5 : 0))
                        .ignoresSafeArea(.all, edges: .vertical)
                        .onTapGesture {
                            withAnimation {
                                x = -width
                            }
                        }
                        .gesture(DragGesture().onChanged({ (value) in
                            withAnimation {
                                if value.translation.width > 0 {
                                    if x < 0 {
                                        x = -width + value.translation.width
                                    }
                                } else {
                                    if x != -width {
                                        x = value.translation.width
                                    }
                                }
                            }
                        })
                            .onEnded({ (value) in
                                withAnimation {
                                    if -x < width / 2 {
                                        x = 0
                                    } else {
                                        x = -width
                                    }
                                }
                            })
                        )
                }
            }
            .onTapGesture {
                withAnimation {
                    x = -width
                }
            }
            .toolbar(.hidden)
            .navigationTitle("")
        }
    }
}

#Preview {
    MainView()
}
