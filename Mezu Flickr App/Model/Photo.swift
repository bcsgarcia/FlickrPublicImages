//
//  Photo.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

/*
{
    "photos": {
        "page": 2,
        "pages": 4729,
        "perpage": 1,
        "total": "4729",
        "photo": [
            {
                "id": "48285503736",
                "owner": "49191827@N00",
                "secret": "7c6c8e82b2",
                "server": "65535",
                "farm": 66,
                "title": "well's fine cars. selma, ca. 2014.",
                "ispublic": 1,
                "isfriend": 0,
                "isfamily": 0
            }
        ]
    },
    "stat": "ok"
}
 */

class Photo: Codable {
    var id: String = ""
    var owner: String = ""
    var title: String = ""
    
    var image: [Size]?
    
    
}
