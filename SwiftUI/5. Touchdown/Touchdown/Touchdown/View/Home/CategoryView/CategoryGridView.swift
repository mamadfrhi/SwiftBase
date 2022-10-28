//
//  CategoryGridView.swift
//  Touchdown
//
//  Created by iMamad on 28.10.22.
//

import SwiftUI


struct CategoryGridView: View {
    //MARK: - PROPERTIES
    //MARK: - BODY
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridLayout,
                      alignment: .center,
                      spacing: columSpacing) {
                Section(header: SectionView(rotateClockwise: true),
                        footer: SectionView(rotateClockwise: false)) {
                    ForEach(categories) { category in
                        CategoryItemView(category: category)
                    } //: LOOP
                }
            } //: GRID
                      .frame(height: 140)
                      .padding(.horizontal, 15)
                      .padding(.vertical, 10)
        } //: SCROLL
    }
}


// MARK: - PREVIEW
struct CategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGridView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(colorBackground)
    }
}
