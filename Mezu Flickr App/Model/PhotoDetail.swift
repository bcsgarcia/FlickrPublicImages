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
