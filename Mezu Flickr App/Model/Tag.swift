//
//  Tag.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 17/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

/*
"id": "1566080-48294642212-33635640",
"author": "49191827@N00",
"authorname": "eyetwist",
"raw": "eyetwist kevin balluff",
"_content": "eyetwistkevinballuff",
"machine_tag": 0
 */

class Tag: Codable {
    var id: String = ""
    var authorname: String = ""
    var raw: String = ""
    var _content: String = ""
}

class Tags: Codable {
    var tag: [Tag] = []
}
