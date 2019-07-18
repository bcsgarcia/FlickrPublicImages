//
//  Config.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 17/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

class Config {
    
    static let sharedInstance = Config()
    
    var userCache: [String: Person] = [:]
    
    var searchUser: User = User()
    var searchPerson: Person = Person()
    
}
