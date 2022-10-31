//
//  Product.swift
//  Touchdown
//
//  Created by iMamad on 31.10.22.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
    private let price: Int
    let description: String
    private let color: [Double]
    
    var red: Double { color[0] }
    var green: Double { color[1] }
    var blue: Double { color[2] }
    
    var formattedPrice: String { "$\(price)"}
}
