//
//  InsetGalleryView.swift
//  Africa
//
//  Created by iMamad on 07.10.22.
//

import SwiftUI

struct InsetGalleryView: View {
    //MARK: - PROPERTIES
    
    let animal: Animal
    
    //MARK: - BODY
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 15) {
                ForEach(animal.gallery, id: \.self) { animalImage in
                    Image(animalImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                }
            } //: FOREACH
        } //: SCROLLVIEW
        
    }
}

// MARK: - PREVIEW
struct InsetGalleryView_Previews: PreviewProvider {
    
    static let animals : [Animal] = Bundle.main.decode("animals.json")
    
    static var previews: some View {
        InsetGalleryView(animal: animals[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}