//
//  SettingsLabelView.swift
//  Fruits
//
//  Created by Mohammad Farrahi on 29.08.22.
//

import SwiftUI

struct SettingsLabelView: View {
    
    // MARK: - PEROPERTIES
    var labelText  : String
    var labelImage : String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Text(labelText.uppercased())
                .fontWeight(.bold)
            Spacer()
            Image(systemName: labelImage)
        }
    }
}

// MARK: - PREIVEW
struct SettingsLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLabelView(labelText: "Fructus",
                          labelImage: "info.circle")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
