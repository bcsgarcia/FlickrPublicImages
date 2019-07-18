//
//  ApiManager.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation


protocol ApiManagerProtocol {
    func findBy(username: String, onComplete: @escaping (User)->Void, onError: @escaping (ApiError)->Void )
    func getPublicPhotos(userId: String, page: Int , onComplete: @escaping (Photos)->Void, onError: @escaping (ApiError)->Void )
    func getSizes(photoId: String, onComplete: @escaping ([Size])->Void, onError: @escaping (ApiError)->Void )
    func getFavorites(photoId: String, onComplete: @escaping (Favorite)->Void, onError: @escaping (ApiError)->Void )
    func getUserInfo(userId: String, onComplete: @escaping (Person)->Void, onError: @escaping (ApiError)->Void )
    func getInfos(photoId: String, onComplete: @escaping (PhotoDetail)->Void, onError: @escaping (ApiError)->Void )
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
                    if let message = responseUser.message {
                        onError(.messageError(message: message))
                    } else {
                        if let user = responseUser.user {
                            onComplete(user)
                        }
                    }
                } catch {
                    print("findBy")
                    return onError(.invalidJSON)
                }
            }, onError: { (error) in onError(error) })
        }
    }
    
    func getPublicPhotos(userId: String, page: Int , onComplete: @escaping (Photos)->Void, onError: @escaping (ApiError)->Void ) {
        let parametros = ["user_id": userId, "page": "\(page)", "per_page": "20", "extras": "url_n,count_comments,count_faves" ]
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
    
    func getFavorites(photoId: String, onComplete: @escaping (Favorite) -> Void, onError: @escaping (ApiError) -> Void) {
        let parametros = ["photo_id": photoId]
        if let request = Router.getFavorites(parametros).request {
            HttpTask.executeTaskWith(request: request, onComplete: { (data) in
                do {
                    let responseFavorites = try JSONDecoder().decode(ResponseFavorites.self, from: data)
                    onComplete(responseFavorites.photo )
                } catch {
                    print("getFavorites")
                    return onError(.invalidJSON)
                }
            }, onError: { (error) in onError(error) })
        }
    }
    
    func getUserInfo(userId: String, onComplete: @escaping (Person) -> Void, onError: @escaping (ApiError) -> Void) {
        let parametros = ["user_id": userId]
        if let request = Router.getUserInfo(parametros).request {
            HttpTask.executeTaskWith(request: request, onComplete: { (data) in
                do {
                    let responsePerson = try JSONDecoder().decode(ResponsePerson.self, from: data)
                    onComplete(responsePerson.person)
                } catch {
                    print("getUserInfo")
                    return onError(.invalidJSON)
                }
            }, onError: { (error) in onError(error) })
        }
    }
    
    func getInfos(photoId: String, onComplete: @escaping (PhotoDetail) -> Void, onError: @escaping (ApiError) -> Void) {
        let parametros = ["photo_id": photoId]
        if let request = Router.getInfos(parametros).request {
            HttpTask.executeTaskWith(request: request, onComplete: { (data) in
                do {
                    let response = try JSONDecoder().decode(ResponsePhotoDetail.self, from: data)
                    onComplete(response.photo)
                } catch {
                    print("getUserInfo")
                    return onError(.invalidJSON)
                }
            }, onError: { (error) in onError(error) })
        }
    }
   
}
