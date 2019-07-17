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
    var photoImage = UIImage()
    var favoriteCount = 0
    var person = Person() {
        didSet {
            /*
            DispatchQueue.global(qos: .userInitiated).async {
                
                if let url = URL(string: "https://farm\(self.person.iconfarm).staticflickr.com/\(self.person.iconserver)/buddyicons/\(self.person.nsid).jpg") {
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.profileImage = image
                                self.updateProfileImage?()
                            }
                        }
                    }
                }
            }
            */
            self.imgProfileUrl = "https://farm\(self.person.iconfarm).staticflickr.com/\(self.person.iconserver)/buddyicons/\(self.person.nsid).jpg"
        }
    }
    var imgProfileUrl = ""
    var profileImage = UIImage()
    
    var updateProfileImage: (() -> ())?
    var updatePhotoImage: (() -> ())?
    
    let apiManagerService: ApiManagerProtocol
    
    // Dependency Injection
    init(photo: Photo, apiManagerService: ApiManagerProtocol = ApiManager()) {
        //print()
        self.photo = photo
        self.apiManagerService = apiManagerService
        getPerson()
        
        //DispatchQueue.main.async { [weak self] in
        //    guard let self = self else { return }
        /*
        DispatchQueue.global(qos: .userInitiated).async {
            //guard let self = self else { return }
            if let url = URL(string: self.photo.url_n) {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.photoImage = image
                            self.updatePhotoImage?()
                        }
                    }
                }
            }
        }
         */
        
    }
    
    func getPerson() {
        
        let dispatchGroup = DispatchGroup()
        
        if let person = Config.sharedInstance.userCache[self.photo.owner] {
            self.person = person
        } else {
            dispatchGroup.enter()
            self.apiManagerService.getUserInfo(userId: self.photo.owner, onComplete: { (person) in
                self.person = person
                Config.sharedInstance.userCache[self.photo.owner] = person
                dispatchGroup.leave()
            }) { (error) in
                print(error)
                dispatchGroup.leave()
            }
        }
    }
}
