//
//  ContentView.swift
//  Africa
//
//  Created by iMamad on 30.09.22.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - PROPERTIES
    
    private let animals: [Animal] = Bundle.main.decode("animals.json")
    private let haptics = UIImpactFeedbackGenerator(style: .medium)
    
    @State private var isGridViewActive = false
    
    @State private var gridLayout: [GridItem] = Array.init(repeating: .init(.flexible()), count: 2)
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            
            Group {
                if isGridViewActive {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: gridLayout,
                                  alignment: .center,
                                  spacing: 10) {
                            ForEach(animals) { animal in
                                NavigationLink(destination: AnimalDetailView(animal: animal)) {
                                    AnimalGridItemView(animal: animal)
                                } //: LINK
                            } //: LOOP
                        } //: GRID
                                  .padding(10)
                                  .animation(.easeIn, value:  UUID())
                    } //: SCROLL
                } else {
                    List {
                        CoverImageView()
                            .frame(height: 300)
                            .listRowInsets(EdgeInsets(top: 0,
                                                      leading: 0,
                                                      bottom: 0,
                                                      trailing: 0))
                        
                        ForEach(animals) { animal in
                            NavigationLink(destination: AnimalDetailView(animal: animal)) {
                                AnimalListItemView(animal: animal)
                            }
                        }
                    } //: List
                } //: CONDITION
            } //: GROUP
            
            .navigationTitle("Africa")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    HStack(spacing: 16) {
                        // LIST
                        Button {
                            print("Listview is activated")
                            isGridViewActive = false
                            haptics.impactOccurred()
                        } label: {
                            Image(systemName: "square.fill.text.grid.1x2")
                                .font(.title2)
                                .foregroundColor(isGridViewActive ? .primary : .accentColor)
                        }
                        
                        // GRID
                        Button {
                            print("Gridview is activated")
                            isGridViewActive = true
                            haptics.impactOccurred()
                        } label: {
                            Image(systemName: "square.grid.2x2")
                                .font(.title2)
                                .foregroundColor(isGridViewActive ? .accentColor : .primary)
                        }
                    } //: HSTACK
                } //: BUTTONS
            } //: TOOLBAR
        } //: NAVIGATION VIEW
    } //: BODY
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
