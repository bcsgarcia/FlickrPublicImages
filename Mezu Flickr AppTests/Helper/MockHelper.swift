//
//  MockHelper.swift
//  Mezu Flickr AppTests
//
//  Created by Garcia, Bruno (B.C.) on 18/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation
import UIKit
@testable import Mezu_Flickr_App

class MockHelper {
    
    class func findByUsernameMock() -> User {
        do {
            guard let asset = NSDataAsset(name: "find-by-username-response", bundle: Bundle.main) else { return User() }
            let response = try JSONDecoder().decode(ResponseUser.self, from: asset.data)
            return response.user ?? User()
        } catch let jsonErr {
            print("Failed to decode:", jsonErr)
            return User()
        }
    }
    
    class func getUserInfoMock() -> Person {
        do {
            guard let asset = NSDataAsset(name: "get-user-info-response", bundle: Bundle.main) else { return Person() }
            let response = try JSONDecoder().decode(ResponsePerson.self, from: asset.data)
            return response.person
        } catch let jsonErr {
            print("Failed to decode:", jsonErr)
            return Person()
        }
    }
    
    class func getPublicPhotosMock() -> Photos {
        do {
            guard let asset = NSDataAsset(name: "get-public-photos-response", bundle: Bundle.main) else { return Photos() }
            let response = try JSONDecoder().decode(ResponsePhotos.self, from: asset.data)
            return response.photos
        } catch let jsonErr {
            print("Failed to decode:", jsonErr)
            return Photos()
        }
    }
    
    class func getInfosMock() -> PhotoDetail {
        do {
            guard let asset = NSDataAsset(name: "get-photo-detail-response", bundle: Bundle.main) else { return PhotoDetail() }
            let response = try JSONDecoder().decode(ResponsePhotoDetail.self, from: asset.data)
            return response.photo
        } catch let jsonErr {
            print("Failed to decode:", jsonErr)
            return PhotoDetail()
        }
    }
    
    
    
}
