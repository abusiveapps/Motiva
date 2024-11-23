//
//  Sources.swift
//  MotivaB
//
//  Created by on 11/20/24.
//

import Foundation
import SwiftData

@Model
class Source {
    var source: String = ""
    var genre: String? = ""
    var quality: String? = ""
    var author: String? = ""
    
    init(source: String, genre: String, quality: String, author: String) {
        self.source = source
        self.genre = genre
        self.quality = quality
        self.author = author
    }
}
