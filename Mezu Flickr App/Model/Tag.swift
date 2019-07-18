//
//  Tag.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 17/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

class Tag: Codable {
    var id: String = ""
    var authorname: String = ""
    var raw: String = ""
    var _content: String = ""
}

class Tags: Codable {
    var tag: [Tag] = []
}
