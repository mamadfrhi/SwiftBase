//
//  ContentView.swift
//  Pinch
//
//  Created by Mohammad Farrahi on 29.06.22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTY
    
    @State private var isAnimating = false
    @State private var imageScale : CGFloat = 1
    @State private var imageOffset : CGSize = .zero
    
    // MARK: - FUNCTION
    private func resetImageState() {
        withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    // MARK: - CONTETNT
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                // MARK: - PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.8), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                // MARK: - 1. TAP GESTURE
                    .onTapGesture(count: 2) {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                            resetImageState()
                        }
                    }
                // MARK: - 1. DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                imageOffset = value.translation
                                withAnimation(.linear(duration: 1)) {
                                }
                            }
                            .onEnded { _ in
                                if imageScale <= 1 {
                                    withAnimation(.spring()) {
                                        resetImageState()
                                    }
                                }
                            }
                    )
            } //: ZSTACK
            .navigationTitle("Pinch and Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                isAnimating = true
            }
            // MARK: - INFO PANEL
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
                , alignment: .top
            )
            // MARK: - CONTROLS
            .overlay(
                Group {
                    HStack {
                        // SCALE DOWN
                        Button {
                            // some action
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        
                        // RESET
                        Button {
                            // some action
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        // SCALE UP
                        Button {
                            // some action
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                    } //: CONTROLS
                    .padding(EdgeInsets(top: 12,
                                        leading: 20,
                                        bottom: 12,
                                        trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                }
                    .padding(.bottom, 30)
                , alignment: .bottom
            )
        } //: NAVIGATION
        .navigationViewStyle(.stack)
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}