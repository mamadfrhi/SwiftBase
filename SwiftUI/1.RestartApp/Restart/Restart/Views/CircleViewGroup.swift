//
//  CircleViewGroup.swift
//  Restart
//
//  Created by Mohammad Farrahi on 21.06.22.
//

import SwiftUI

struct CircleViewGroup: View {
    // MARK: Property
    @State var ShapeColor: Color
    @State var ShapeOpacity: Double
    @State private var isAnimating = false
    
    // MARK: Body
    var body: some View {
        ZStack {
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        }//: ZStack
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
    }
}

// MARK: Preview
struct CircleViewGroup_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            CircleViewGroup(ShapeColor: .white, ShapeOpacity: 0.2)
        }
    }
}
