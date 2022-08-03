//
//  PageModel.swift
//  Pinch
//
//  Created by Mohammad Farrahi on 03.08.22.
//

import Foundation

struct Page: Identifiable {
    var id: Int    
    let imageName: String
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
