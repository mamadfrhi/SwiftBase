//
//  NavigationBarView.swift
//  Touchdown
//
//  Created by iMamad on 21.10.22.
//

import SwiftUI

struct NavigationBarView: View {
    //MARK: - PROPERTIES
    @State private var isAnimated = false
    
    //MARK: - BODY
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .foregroundColor(.black)
            } //: BUTTON
            
            Spacer()
            
            LogoView()
                .opacity(isAnimated ? 1 : 0)
                .offset(x: 0,y: isAnimated ? 0 : -25)
                .onAppear {
                    withAnimation(.easeOut(duration: 0.5)) {
                        isAnimated.toggle()
                    }
                }
            
            Spacer()
            
            Button {
                
            } label: {
                ZStack {
                    Image(systemName: "cart")
                        .font(.title)
                        .foregroundColor(.black)
                    
                    Circle()
                        .fill(.red)
                        .frame(width: 14, height: 14, alignment: .center)
                        .offset(x: 14, y: -10)
                } //: ZSTACK
            } //: BUTTON
            
        } //: HSTACK
    }
}


// MARK: - PREVIEW
struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
