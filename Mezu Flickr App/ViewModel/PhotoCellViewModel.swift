//
//  PhotoCellViewModel.swift
//  Mezu Flickr App
//
//  Created by Bruno Garcia on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation
import UIKit


class PhotoCellViewModel {
    
    let photo: Photo
    var imageSizeList: [Size] = []
    
    let apiManagerService: ApiManagerProtocol
    
    // Dependency Injection
    init(photo: Photo, apiManagerService: ApiManagerProtocol = ApiManager()) {
        self.photo = photo
        self.apiManagerService = apiManagerService
        
    }
    
    func getImageList(onComplete: @escaping ([Size])->Void) {
        self.apiManagerService.getSizes(photoId: self.photo.id, onComplete: { (imageSizeList) in
            onComplete(imageSizeList)
        }) { (error) in
            print(error)
        }
    }
    
}
