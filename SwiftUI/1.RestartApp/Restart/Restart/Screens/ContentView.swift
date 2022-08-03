//
//  ContentView.swift
//  Restart
//
//  Created by Mohammad Farrahi on 17.06.22.
//

import SwiftUI

struct ContentView: View {
    // MARK: Property
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    // MARK: Body
    var body: some View {
        ZStack {
            if isOnboardingViewActive {
                OnboardingView()
            } else {
                HomeView() 
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
