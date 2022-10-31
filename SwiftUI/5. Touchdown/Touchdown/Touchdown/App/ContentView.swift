//
//  ContentView.swift
//  Touchdown
//
//  Created by iMamad on 21.10.22.
//

import SwiftUI

struct ContentView: View {
    //MARK: PROPERTIES
    //MARK: - BODY
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                NavigationBarView()
                    .padding(.horizontal, 15)
                    .padding(.bottom)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(.white)
                    .shadow(color: .black.opacity(0.05),
                            radius: 5, x: 0, y: 5)
                
                Spacer()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        FeaturedTabView()
                            .padding(.vertical, 20)
                            .frame(minHeight: 280)
                        
                        CategoryGridView()
                        
                        TitleView(title: "Helmets")
                        
                        FooterView()
                            .padding(.horizontal)
                    } //: VSTACK
                } //: SCROLL
                
            } //: VSTACK
            .background(colorBackground.ignoresSafeArea(.all, edges: .all))
        } //: ZSTACK
        .ignoresSafeArea(.all, edges: .top)
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
