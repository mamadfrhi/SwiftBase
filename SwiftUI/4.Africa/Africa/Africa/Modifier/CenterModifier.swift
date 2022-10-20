//
//  CenterModifier.swift
//  Africa
//
//  Created by iMamad on 20.10.22.
//

import SwiftUI

struct CenterModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
