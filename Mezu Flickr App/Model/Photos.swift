//
//  Photos.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

class Photos: Codable {
    var page: Int = 0
    var pages: Int = 0
    var perpage: Int = 0
    var total: String = ""
    var photo: [Photo] = []
}

class ResponsePhotos: Codable {
    var photos: Photos = Photos()
    var stat: String = ""
}
