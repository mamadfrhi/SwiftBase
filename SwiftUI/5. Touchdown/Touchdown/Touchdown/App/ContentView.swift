//
//  ContentView.swift
//  Touchdown
//
//  Created by iMamad on 21.10.22.
//

import SwiftUI

struct ContentView: View {
    //MARK: PROPERTIES
    //MARK: - BODY
    var body: some View {
        FooterView()
            .padding(.horizontal)
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
