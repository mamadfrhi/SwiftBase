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
                        
                        Divider().padding(.vertical, 4)
                        
                        HStack(alignment: .center, spacing: 10) {
                            
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(9)
                            
                            
                            Text("Most fruits are naturally low in fat, sodium, and calories. None have cholesterool. Fruits are sources of many essential nuterients, including potassium, dietary fiber, vitamins, and much more.")
                                .font(.footnote)
                        }
                    } //: BOX
                    .padding()
                    
                    // MARK: - SECTION 2
                    
                    // MARK: - SECTION 3
                    
                    GroupBox(
                        label:
                            SettingsLabelView(labelText: "Application",
                                              labelImage: "apps.iphone")
                    ) {
                        
                        SettingsRowView(name: "Developer", content: "iMamad")
                        SettingsRowView(name: "Designer", content: "Mamad Mamadian")
                        SettingsRowView(name: "Compatibility", content: "iOS 14")
                        
                        SettingsRowView(name: "Developer",
                                        linkLabel: "Contact",
                                        linkDestination: "www.linkedin.com/in/imamad/")
                        
                        SettingsRowView(name: "Twitter",
                                        linkLabel: "@iMamad_",
                                        linkDestination: "www.twitter.com/iMamad_")
                        
                        SettingsRowView(name: "SwiftUI", content: "2.0")
                        SettingsRowView(name: "Version", content: "1.1.0")
                        
                    } //: BOX
                    .padding()
                    
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
