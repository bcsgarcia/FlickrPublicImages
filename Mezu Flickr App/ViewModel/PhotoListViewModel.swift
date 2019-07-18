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
        apiManagerService.findBy(username: username, onComplete: { (user) in
            Config.sharedInstance.searchUser = user
            
            self.fetchPerson()
            self.photoCellViewModels = [PhotoCellViewModel]()
            self.page = 0
            self.fetchData()
        }) { (error) in
            self.error = error
            self.isLoading = false
        }
    }
    
    fileprivate func fetchPerson(){
        apiManagerService.getUserInfo(userId: Config.sharedInstance.searchUser.nsid, onComplete: { (person) in
            Config.sharedInstance.userCache[person.nsid] = person
            Config.sharedInstance.searchPerson = person
            self.didFinishUserFetch?()
        }) { (error) in
            self.error = error
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
        
        apiManagerService.getPublicPhotos(userId: Config.sharedInstance.searchUser.nsid, page: page, onComplete: { (photos) in
            self.error = nil
            self.photoList = photos
        }, onError: { (error) in
            self.isLoading = false
            self.error = error
            return
        })
        
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
