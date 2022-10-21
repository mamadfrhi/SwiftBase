//
//  LogoView.swift
//  Touchdown
//
//  Created by iMamad on 21.10.22.
//

import SwiftUI

struct LogoView: View {
    //MARK: - PROPERTIES
    //MARK: - BODY
    var body: some View {
        HStack(spacing: 4) {
            Text("Touch".uppercased())
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.black)
            
            Image("logo-dark")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20, alignment: .center)
            Text("Down".uppercased())
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.black)
        }
    }
}


// MARK: - PREVIEW
struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
