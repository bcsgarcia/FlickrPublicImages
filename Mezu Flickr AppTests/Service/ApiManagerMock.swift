//
//  ApiManagerMock.swift
//  Mezu Flickr AppTests
//
//  Created by Garcia, Bruno (B.C.) on 18/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation
@testable import Mezu_Flickr_App

class ApiManagerMock: ApiManagerProtocol {
    
    // MARK: - Complete Closures
     var completeClosureFindBy: ((User?, ApiError?) -> ())!
     var completeClosureGetUserInfo: ((Person?, ApiError?) -> ())!
     var completeClosureGetPublicPhotos: ((Photos?, ApiError?) -> ())!
     var completeClosureGetInfos: ((PhotoDetail?, ApiError?) -> ())!
    
    // MARK: - FindByUsername
    func findBy(username: String, completion: @escaping (User?, ApiError?) -> ()) {
        completeClosureFindBy = completion
    }
    
    func fetchFindBySuccess() {
        completeClosureFindBy( MockHelper.findByUsernameMock(), nil )
    }
    
    func fetchFindByFail(error: ApiError?) {
        completeClosureFindBy( nil, error )
    }
    
    // MARK: - GetUserInfo
    func getUserInfo(userId: String, completion: @escaping (Person?, ApiError?) -> ()) {
        completeClosureGetUserInfo = completion
    }
    
    func fetchGetUserInfoSuccess() {
        completeClosureGetUserInfo( MockHelper.getUserInfoMock(), nil )
    }
    
    func fetchGetUserInfoFail(error: ApiError?) {
        completeClosureGetUserInfo( nil, error )
    }
    
    // MARK: - GetPublicPhotos
    func getPublicPhotos(userId: String, page: Int, completion: @escaping (Photos?, ApiError?) -> ()) {
        completeClosureGetPublicPhotos = completion
    }
    
    func fetchGetPublicPhotosSuccess() {
        completeClosureGetPublicPhotos( MockHelper.getPublicPhotosMock(), nil )
    }
    
    func fetchGetPublicPhotosFail(error: ApiError?) {
        completeClosureGetPublicPhotos( nil, error )
    }
    
    // MARK: - GetInfos
    func getInfos(photoId: String, completion: @escaping (PhotoDetail?, ApiError?) -> ()) {
        completeClosureGetInfos = completion
    }
    
    func fetchGetInfosSuccess() {
        completeClosureGetInfos( MockHelper.getInfosMock(), nil )
    }
    
    func fetchGetInfosFail(error: ApiError?) {
        completeClosureGetInfos( nil, error )
    }
    
}
