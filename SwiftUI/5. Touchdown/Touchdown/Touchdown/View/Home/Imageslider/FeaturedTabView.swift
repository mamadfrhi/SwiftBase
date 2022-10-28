//
//  FeaturedTabView.swift
//  Touchdown
//
//  Created by iMamad on 28.10.22.
//

import SwiftUI

struct FeaturedTabView: View {
    //MARK: - PROPERTIES
    //MARK: - BODY
    var body: some View {
        TabView {
            ForEach(players) { player in
                FeaturedItemView(player: player)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 15)
            }
        }
        .tabViewStyle(.page)
    }
}


// MARK: - PREVIEW
struct FeaturedTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedTabView()
            .previewDevice("iPhone 12 pro")
            .background(colorGray)
    }
}
