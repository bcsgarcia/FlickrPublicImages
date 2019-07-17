//
//  PhotoDetailDate.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 17/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

/*
"dates": {
    "posted": "1563236442",
    "taken": "2016-05-20 16:09:34",
    "takengranularity": "0",
    "takenunknown": "0",
    "lastupdate": "1563281796"
}
*/

class PhotoDetailDate: Codable {
    var posted: String = ""
    var taken: String = ""
    
}
