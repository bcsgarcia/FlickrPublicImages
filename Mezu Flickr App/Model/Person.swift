//
//  Person.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 17/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

/*
 http://farm{icon-farm}.staticflickr.com/{icon-server}/buddyicons/{nsid}.jpg
*/

class Person: Codable {
    var id: String = ""
    var nsid: String = ""
    var iconfarm: Int = 0
    var iconserver: String = "" 
    var username: Content = Content()
    
    var realname: Content? 
    var profileUrl: String?
}

class ResponsePerson: Codable {
    var person: Person = Person()
    var stat: String = ""
}
