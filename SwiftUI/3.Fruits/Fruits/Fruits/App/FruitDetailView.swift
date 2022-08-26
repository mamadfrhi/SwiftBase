//
//  FruitDetailView.swift
//  Fruits
//
//  Created by Mohammad Farrahi on 26.08.22.
//

import SwiftUI

struct FruitDetailView: View {
    
    // MARK: - PROPERTEIS
    
    var fruit: Fruit
    
    // MARK: - BODY
    
    var body: some View {
        Text(fruit.title)
    }
}


// MARK: - PREVIEW

struct FruitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FruitDetailView(fruit: fruitsData[0])
            .previewDevice("iPhone 11 Pro")
    }
}
