//
//  SourceLinkView.swift
//  Fruits
//
//  Created by Mohammad Farrahi on 26.08.22.
//

import SwiftUI

struct SourceLinkView: View {
    var body: some View {
        GroupBox() {
            HStack {
                
                Text("Content Source")
                
                Spacer()
                
                Link("Wikipedia", destination: URL(string: "https://www.wikipedia.com/")!)
                
                Image(systemName: "arrow.up.right.square")
            } //: HSTACK
            .font(.footnote)
        } //: GROUP BOX
    }
}

struct SourceLinkView_Previews: PreviewProvider {
    static var previews: some View {
        SourceLinkView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
