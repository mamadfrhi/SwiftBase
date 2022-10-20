//
//  CreaditsView.swift
//  Africa
//
//  Created by iMamad on 20.10.22.
//

import SwiftUI

struct CreditsView: View {
    //MARK: - PROPERTIES
    //MARK: - BODY
    var body: some View {
        VStack {
            
            Image("compass")
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            Text("""
Copyright © iMamad
All rights reserved
""")
            .font(.footnote)
            .multilineTextAlignment(.center)
        } //: VSTACK
        .padding()
        .opacity(0.4)
    }
    
}


// MARK: - PREVIEW
struct CreaditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
