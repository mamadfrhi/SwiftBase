//
//  SettingsRowView.swift
//  Fruits
//
//  Created by Mohammad Farrahi on 29.08.22.
//

import SwiftUI

struct SettingsRowView: View {
    
    // MARK: - PEROPERTIES
    let name     : String
    var content  : String? = nil
    
    var linkLabel       : String? = nil
    var linkDestination : String? = nil
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Divider().padding(.vertical, 4)
            HStack {
                Text(name)
                    .foregroundColor(Color.gray)
                Spacer()
                if content != nil {
                    Text(content!)
                } else if linkLabel != nil && linkDestination != nil {
                    Link(linkLabel!, destination: URL(string: "https://\(linkDestination!)")!)
                    Image(systemName: "arrow.up.right.square")
                        .foregroundColor(.pink)
                }
            }
        }
    }
}

// MARK: - PREVIEW
struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsRowView(name: "Developer", content: "iMamad")
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 375, height: 60))
                .padding()
            SettingsRowView(name: "Website",
                            linkLabel: "SwiftUI Project",
                            linkDestination: "www.linkedin.com/imamad")
                .previewLayout(.fixed(width: 375, height: 60))
                .padding()
        }
    }
}
