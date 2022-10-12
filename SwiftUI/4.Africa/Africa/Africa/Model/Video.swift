//
//  VideoModel.swift
//  Africa
//
//  Created by iMamad on 12.10.22.
//

import Foundation

struct Video : Codable, Identifiable {
    let id: String
    let name: String
    let headline: String
    
    var thumbnail: String {
        "video-\(id)"
    }
}
