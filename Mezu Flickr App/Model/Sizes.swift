//
//  Sizes.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

class Sizes: Codable {
    var canblog: Int = 0
    var canprint: Int = 0
    var candownload: Int = 0
    var size: [Size] = []
}

class ResponseSizes: Codable {
    var sizes: Sizes = Sizes()
    var stat: String = ""
}
