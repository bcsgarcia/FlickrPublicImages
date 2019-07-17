//
//  Favorite.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 17/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

class Favorite: Codable {
    var id: String = ""
    var page: Int = 0
    var pages: Int = 0
    var perpage: Int = 0
    var total: Int = 0
}

class ResponseFavorites: Codable {
    var photo: Favorite = Favorite()
    var stat: String = ""
}

