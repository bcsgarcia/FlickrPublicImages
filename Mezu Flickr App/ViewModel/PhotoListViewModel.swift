//
//  PhotoListViewModel.swift
//  Mezu Flickr App
//
//  Created by Bruno Garcia on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation


class PhotoListViewModel {
    
    private var photoList: Photos? {
        didSet {
            guard let pl = photoList else { return }
            self.setupProperties(with: pl)
            self.isLoading = false
            self.didFinishFetch?()
            
        }
    }
    
    var page = 0
    let apiManagerService: ApiManagerProtocol
    
    var photoCellViewModels = [PhotoCellViewModel]()
    
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
    var didFinishUserFetch: (() -> ())?
    
    
    func fetchUser(username: String) {
        isLoading = true
        apiManagerService.findBy(username: username) { (user, error) in
            
            if let error = error {
                self.error = error
                self.isLoading = false
                return
            }
            
            guard let user = user else {
                self.error = .messageError(message: "No user found")
                self.isLoading = false
                return
            }
            
            Config.sharedInstance.searchUser = user
            
            self.fetchPerson()
            self.photoCellViewModels = [PhotoCellViewModel]()
            self.page = 0
            self.fetchData()
        }
    }
    
    fileprivate func fetchPerson(){
        apiManagerService.getUserInfo(userId: Config.sharedInstance.searchUser.nsid) { (person, error) in
            
            if let error = error {
                self.error = error
                return
            }
            
            guard let person = person else {
                self.error = .messageError(message: "No user found")
                return
            }
            
            Config.sharedInstance.userCache[person.nsid] = person
            Config.sharedInstance.searchPerson = person
            self.didFinishUserFetch?()
        }
    }
    
    
    // MARK: - Network call
    func fetchData() {
        isLoading = true
        
        if Config.sharedInstance.searchUser.nsid == "" {
            fetchUser(username: "eyetwist")
            return
        }
        
        if !CheckInternet.Connection() {
            isLoading = false
            error = .noInternetConnection
            return
        }
        
        guard let page = plusOnePage() else {
            isLoading = false
            return
        }
        
        apiManagerService.getPublicPhotos(userId: Config.sharedInstance.searchUser.nsid, page: page) { (photos, error) in
            
            if let error = error {
                self.isLoading = false
                self.error = error
                return
            }
            
            guard let photos = photos else {
                self.isLoading = false
                self.error = .messageError(message: "No photos found")
                return
            }
            
            self.error = nil
            self.photoList = photos
        }
        
    }
    
    // MARK: - UI Logic
    private func plusOnePage() -> Int? {
        page += 1
        return page
    }

    private func setupProperties(with photoList: Photos) {
        
        
        //if let photoList = photoList.photo {
            self.photoCellViewModels = self.photoCellViewModels + photoList.photo.map({return PhotoCellViewModel(photo: $0, apiManagerService: self.apiManagerService)})
            //print(self.repositoriesCellViewModels.count)
        //}
        
        
    }
    
}
