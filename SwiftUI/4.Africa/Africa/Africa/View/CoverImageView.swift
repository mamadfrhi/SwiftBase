//
//  CoverImageView.swift
//  Africa
//
//  Created by iMamad on 07.10.22.
//

import SwiftUI

struct CoverImageView: View {
    
    //MARK: - Properteis
    let coverImages : [CoverImage] = Bundle.main.decode("covers.json")
    
    //MARK: - BODY
    var body: some View {
        TabView {
            ForEach(coverImages) { image in
                Image(image.name)
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
