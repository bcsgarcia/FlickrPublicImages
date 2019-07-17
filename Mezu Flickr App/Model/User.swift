//
//  User.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

class User: Codable {
    var id: String = ""
    var nsid: String = ""
    var username: [String:String] = [:]
}

class ResponseUser: Codable {
    var user: User = User()
    var stat: String = ""
}
