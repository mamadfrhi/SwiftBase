//
//  SettingsView.swift
//  Fruits
//
//  Created by Mohammad Farrahi on 29.08.22.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - PEROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    // MARK: - SECTION 1
                    
                    GroupBox(
                        label:
                            SettingsLabelView(labelText: "Fructus",
                                              labelImage: "info.circle")
                    ) {
                        Text("It's a test!")
                    }
                    
                    // MARK: - SECTION 2
                    
                    // MARK: - SECTION 3
                } //: VSTACK
                .navigationBarTitle(Text("Settings"))
                .navigationBarItems(trailing: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                }))
                .navigationBarTitleDisplayMode(.large)
            } //: SCROLL
        } //: NAVIGATION
    }
}


// MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
