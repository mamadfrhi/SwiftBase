//
//  MotionAnimationView.swift
//  Africa
//
//  Created by iMamad on 13.10.22.
//

import SwiftUI

struct MotionAnimationView: View {
    //MARK: - PROPERTIES
    
    @State private var randomCircle = Int.random(in: 12...16)
    @State private var isAnimating  = false
    
    //MARK: - BODY
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(0...randomCircle, id: \.self) { random in
                    Circle()
                        .foregroundColor(.gray)
                        .opacity(0.15)
                        .frame(width: randomSize(),
                               height: randomSize(),
                               alignment: .center)
                        .scaleEffect(randomScale())
                        .position(
                            x: randomCoordinate(max: geo.size.width),
                            y: randomCoordinate(max: geo.size.height)
                        )
                        .animation(
                            .interpolatingSpring(stiffness: 0.5,
                                                 damping: 0.5)
                            .repeatForever()
                            .speed(randomSpeed())
                            .delay(randomDelay())
                            ,value: isAnimating)
                } //: LOOP
            } //: ZSTACK
            .drawingGroup()
            .onAppear {
                isAnimating = true
            }
        } //: GEOMETRY
    }
    
    //MARK: FUNCTIONS
    // 1. Random Coordinate
    private func randomCoordinate(max: CGFloat) -> CGFloat {
        CGFloat.random(in: 0...max)
    }
    
    // 2. Random Size
    private func randomSize() -> CGFloat {
        CGFloat.random(in: 10...300)
    }
    
    // 3. Random Scale
    private func randomScale() -> CGFloat {
        CGFloat.random(in: 0.1...2.0)
    }
    
    // 4. Random Speed
    private func randomSpeed() -> Double {
        Double.random(in: 0.025...1.0)
    }
    
    // 5. Random Delay
    private func randomDelay() -> Double {
        Double.random(in: 0...2)
    }
}


// MARK: - PREVIEW
struct MotionAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        MotionAnimationView()
            .previewDevice("iPhone 11 Pro")
    }
}
