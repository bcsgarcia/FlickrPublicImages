//
//  PhotoDetailViewModel.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 17/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation

class PhotoDetailViewModel {
    
    var photoDetail: PhotoDetail? {
        didSet {
            self.isLoading = false
            self.didFinishFetch?()
            
        }
    }
    
    let apiManagerService: ApiManagerProtocol
    
    var error: ApiError? {
        didSet { self.showAlertClosure?() }
    }
    
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    // Dependency Injection
    init( apiManagerService: ApiManagerProtocol = ApiManager()) {
        self.apiManagerService = apiManagerService
    }
    
    // MARK: - Closures for callback
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Network call
    func fetchData(photoId: String) {
        isLoading = true
        
        if !CheckInternet.Connection() {
            isLoading = false
            error = .noInternetConnection
            return
        }
        
        apiManagerService.getInfos(photoId: photoId) { (photoDetail, error) in
            
            if let error = error {
                self.isLoading = false
                self.error = error
                return
            }
            
            guard let photoDetail = photoDetail else {
                self.isLoading = false
                self.error = .messageError(message: "No photo found")
                return
            }
            
            self.error = nil
            self.photoDetail = photoDetail
        }
        
    }
    
}
