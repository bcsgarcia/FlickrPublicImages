//
//  PhotoDetail.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 17/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

class PhotoDetail: Codable {
    var id: String = ""
    var title: Content = Content()
    var description: Content = Content()
    var dates: PhotoDetailDate = PhotoDetailDate()
    var views: String = ""
    var tags: Tags = Tags()
    
}

class ResponsePhotoDetail: Codable {
    var photo: PhotoDetail = PhotoDetail()
    var stat: String = ""
}

/*
{
    "photo": {
        "id": "48294642212",
        "secret": "dcf1be876e",
        "server": "65535",
        "farm": 66,
        "dateuploaded": "1563236442",
        "isfavorite": 0,
        "license": "0",
        "safety_level": "0",
        "rotation": 0,
        "owner": {
            "nsid": "49191827@N00",
            "username": "eyetwist",
            "realname": "",
            "location": "venice beach, ca",
            "iconserver": "3734",
            "iconfarm": 4,
            "path_alias": "eyetwist"
        },
        "title": {
            "_content": "first responder. gold point, nv. 2016."
        },
        "description": {
            "_content": "derelict 1960s-vintage fire engine at the gold point ghost town in western nevada. mamiya 6MF 50mm f\/4 + kodak portra 160. lab: the icon, los angeles, ca. scan: epson V750. exif tags: lenstagger"
        },
        "visibility": {
            "ispublic": 1,
            "isfriend": 0,
            "isfamily": 0
        },
        "dates": {
            "posted": "1563236442",
            "taken": "2016-05-20 16:09:34",
            "takengranularity": "0",
            "takenunknown": "0",
            "lastupdate": "1563281796"
        },
        "views": "1198",
        "editability": {
            "cancomment": 0,
            "canaddmeta": 0
        },
        "publiceditability": {
            "cancomment": 1,
            "canaddmeta": 0
        },
        "usage": {
            "candownload": 0,
            "canblog": 0,
            "canprint": 0,
            "canshare": 1
        },
        "comments": {
            "_content": "0"
        },
        "notes": {
            "note": []
        },
        "people": {
            "haspeople": 0
        },
        "tags": {
            "tag": [
                {
                    "id": "1566080-48294642212-33635640",
                    "author": "49191827@N00",
                    "authorname": "eyetwist",
                    "raw": "eyetwist kevin balluff",
                    "_content": "eyetwistkevinballuff",
                    "machine_tag": 0
                }
            ]
        },
        
        "media": "photo"
    },
    "stat": "ok"
}
 */

