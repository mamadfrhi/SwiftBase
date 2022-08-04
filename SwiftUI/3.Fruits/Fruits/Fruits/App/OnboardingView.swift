//
//  OnboardingView.swift
//  Fruits
//
//  Created by Mohammad Farrahi on 04.08.22.
//

import SwiftUI

struct OnboardingView: View {
    
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    
    var body: some View {
        TabView {
            ForEach(0 ..< 5) { item in
                FruitCardView()
            } //: LOOP
        } //: TAB
        .tabViewStyle(.page)
        .padding(.vertical, 20)
    }
}

// MARK: - PREVIEW
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
