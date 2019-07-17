//
//  User.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation
/*
{
    "user": {
        "id": "147698239@N02",
        "nsid": "147698239@N02",
        "username": {
            "_content": "brunogarcia12"
        }
    },
    "stat": "ok"
}
 */

class User: Codable {
    var id: String = ""
    var nsid: String = ""
    var username: [String:String] = [:]
}

class ResponseUser: Codable {
    var user: User = User()
    var stat: String = ""
}
