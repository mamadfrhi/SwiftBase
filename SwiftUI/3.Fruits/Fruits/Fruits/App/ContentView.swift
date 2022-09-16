//
//  ContentView.swift
//  Fruits
//
//  Created by Mohammad Farrahi on 04.08.22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    var fruits: [Fruit] = fruitsData
    @State var isShowingSettings = false
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            List {
                ForEach(fruits.shuffled()) { fruit in
                    NavigationLink(destination: FruitDetailView(fruit: fruit)) {
                        FruitRowView(fruit: fruit)
                            .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Fruits")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        isShowingSettings = true
                    }, label: {
                        Image(systemName: "slider.horizontal.3")
                    }))
            .sheet(isPresented: $isShowingSettings) {
                SettingsView()
            }
        } //: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(fruits: fruitsData)
    }
}
