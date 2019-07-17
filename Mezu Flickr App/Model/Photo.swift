//
//  Photo.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

class Photo: Codable {
    var id: String = ""
    var owner: String = ""
    var title: String = ""
    var image: [Size]?
    var url_n: String = ""
    var count_comments: String = ""
    var count_faves: String = ""
}
