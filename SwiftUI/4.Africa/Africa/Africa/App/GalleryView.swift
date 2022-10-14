//
//  GalleryView.swift
//  Africa
//
//  Created by iMamad on 07.10.22.
//

import SwiftUI

struct GalleryView: View {
    
    //MARK: - PROPERTIES
    
    @State private var selectedAnimal : String = "lion"
    let animals : [Animal] = Bundle.main.decode("animals.json")
    
    // Simple Grid Definition
    // let gridColumns : [GridItem] = [
    //     GridItem(.flexible()),
    //     GridItem(.flexible()),
    //     GridItem(.flexible())
    // ]
    
    // Efficient Grid Definition
    // let gridColumns: [GridItem] =
    // Array.init(repeating: GridItem(.flexible()), count: 3)
    
    // Dynamic Grid Layout
    @State private var gridLayout : [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn = 3.0
    
    private func gridSwitch() {
        gridLayout = Array(repeating: .init(.flexible()), count: Int(gridColumn))
    }
    
    //MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 30) {
                
                //MARK: - Image
                Image(selectedAnimal)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 8)
                    )
                
                //MARK: - Image
                Slider(value: $gridColumn, in: 2...4)
                    .padding(.horizontal)
                    .onChange(of: gridColumn) {
                        _ in
                        gridSwitch()
                    }
                
                //MARK: - GTRID
                LazyVGrid(columns: gridLayout,
                          alignment: .center,
                          spacing: 10) {
                    ForEach(animals) { animal in
                        Image(animal.image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(lineWidth: 1)
                            )
                            .onTapGesture {
                                selectedAnimal = animal.image
                            }
                    } //: LOOP
                } //: GRID
                          .animation(.easeInOut, value: UUID())
                .onAppear {
                    gridSwitch()
                }
            } //: VSTACK
            .padding(.horizontal, 10)
            .padding(.vertical, 50)
        } //: SCROLL
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(MotionAnimationView())
    }
}


// MARK: - PREVIEW
struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
