//
//  Size.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

/*
{
    "label": "Square",
    "width": 75,
    "height": 75,
    "source": "https:\/\/live.staticflickr.com\/65535\/48294642212_dcf1be876e_s.jpg",
    "url": "https:\/\/www.flickr.com\/photos\/eyetwist\/48294642212\/sizes\/sq\/",
    "media": "photo"
},
*/


class Size: Codable {
    var label: String = ""
    //var width: String = ""
    //var height: String = ""
    var source: String = ""
    var url: String = ""
    var media: String = ""
}
