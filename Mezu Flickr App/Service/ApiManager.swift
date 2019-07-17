//
//  ApiManager.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation


protocol ApiManagerProtocol {
    //func fetchStarredRepo(page: Int, completion: @escaping (GitResponse?, RequestError?) -> ())
    func findBy(username: String, onComplete: @escaping (User)->Void, onError: @escaping (ApiError)->Void )
    func getPublicPhotos(userId: String, page: Int , onComplete: @escaping (Photos)->Void, onError: @escaping (ApiError)->Void )
    func getSizes(photoId: String, onComplete: @escaping ([Size])->Void, onError: @escaping (ApiError)->Void )
}

class ApiManager : ApiManagerProtocol {
    
    //let apiKey = "7ec9d191b3831b20d5b7695d49db8946"
    //let apiSecret = "a05ae08ca0aec956"
    
    func findBy(username: String, onComplete: @escaping (User)->Void, onError: @escaping (ApiError)->Void ) {
        let parametros = ["username": username ]
        if let request = Router.findByUsername(parametros).request {
            HttpTask.executeTaskWith(request: request, onComplete: { (data) in
                do {
                    let responseUser = try JSONDecoder().decode(ResponseUser.self, from: data)
                    onComplete(responseUser.user)
                } catch {
                    print("findBy")
                    return onError(.invalidJSON)
                }
            }, onError: { (error) in onError(error) })
        }
    }
    
    func getPublicPhotos(userId: String, page: Int , onComplete: @escaping (Photos)->Void, onError: @escaping (ApiError)->Void ) {
        let parametros = ["user_id": userId, "page": "\(page)", "per_page": "20" ]
        if let request = Router.getPublicPhotos(parametros).request {
            HttpTask.executeTaskWith(request: request, onComplete: { (data) in
                do {
                    let responsePhotos = try JSONDecoder().decode(ResponsePhotos.self, from: data)
                    onComplete(responsePhotos.photos)
                } catch {
                    print("getPublicPhotos")
                    return onError(.invalidJSON)
                }
            }, onError: { (error) in onError(error) })
        }
    }
    
    func getSizes(photoId: String, onComplete: @escaping ([Size])->Void, onError: @escaping (ApiError)->Void ) {
        let parametros = ["photo_id": photoId]
        if let request = Router.getSizes(parametros).request {
            HttpTask.executeTaskWith(request: request, onComplete: { (data) in
                do {
                    let responseSizes = try JSONDecoder().decode(ResponseSizes.self, from: data)
                    onComplete(responseSizes.sizes.size)
                } catch {
                    print("getSizes")
                    return onError(.invalidJSON)
                }
            }, onError: { (error) in onError(error) })
        }
    }
    
   
}
