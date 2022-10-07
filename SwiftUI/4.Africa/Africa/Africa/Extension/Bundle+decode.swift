//
//  Extension.swift
//  Africa
//
//  Created by iMamad on 07.10.22.
//

import Foundation

extension Bundle {
    func decode(_ file: String) -> [CoverImage] {
        // locate the json file
        guard let url = self.url(forResource: file, withExtension: nil)
        else { fatalError("Failed to lcoate \(file) in bundle.") }
        
        // create a property for data
        guard let data = try? Data(contentsOf: url)
        else { fatalError("Failed to laod \(file) from bundle.") }
        
        // create a decoder
        let decoder = JSONDecoder()
        
        // create a property for the decoded data
        guard let loaded = try? decoder.decode([CoverImage].self, from: data)
        else { fatalError("Failed to decode \(file) from bundle.") }
        
        // return data
        return loaded
    }
}
