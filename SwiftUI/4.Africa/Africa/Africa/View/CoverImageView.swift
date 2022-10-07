//
//  CoverImageView.swift
//  Africa
//
//  Created by iMamad on 07.10.22.
//

import SwiftUI

struct CoverImageView: View {
    
    //MARK: - Properteis
    
    //MARK: - BODY
    var body: some View {
        TabView {
            ForEach(0 ..< 5) { item in
                Image("cover-lion")
                    .resizable()
                .scaledToFill()
            }
        } //: TABVIEW
        .tabViewStyle(PageTabViewStyle())
    } //: BODY
}

// MARK: - PREVIEW
struct CoverImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoverImageView()
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
