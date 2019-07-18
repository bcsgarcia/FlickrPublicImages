//
//  ApiManager.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation


protocol ApiManagerProtocol {
    func findBy(username: String, completion: @escaping (User?, ApiError?) -> ())
    func getPublicPhotos(userId: String, page: Int , completion: @escaping (Photos?, ApiError?)->())
    //func getSizes(photoId: String, completion: @escaping ([Size]?, ApiError?)->())
    //func getFavorites(photoId: String, completion: @escaping (Favorite?, ApiError?)->())
    func getUserInfo(userId: String, completion: @escaping (Person?, ApiError?)->())
    func getInfos(photoId: String, completion: @escaping (PhotoDetail?, ApiError?)->())
}

class ApiManager : ApiManagerProtocol {
    
    //let apiKey = "7ec9d191b3831b20d5b7695d49db8946"
    //let apiSecret = "a05ae08ca0aec956"
    
    func findBy(username: String, completion: @escaping (User?, ApiError?)->()) {
        let parametros = ["username": username ]
        if let request = Router.findByUsername(parametros).request {
            HttpTask.executeTaskWith(request: request, onComplete: { (data) in
                do {
                    let responseUser = try JSONDecoder().decode(ResponseUser.self, from: data)
                    if let message = responseUser.message {
                        completion(nil, .messageError(message: message))
                    } else {
                        if let user = responseUser.user {
                            completion(user, nil)
                        }
                    }
                } catch {
                    print("findBy")
                    return completion(nil, .invalidJSON)
                }
            }, onError: { (error) in
                completion(nil, error)
            })
        }
    }
    
    func getPublicPhotos(userId: String, page: Int , completion: @escaping (Photos?, ApiError?)->()) {
        let parametros = ["user_id": userId, "page": "\(page)", "per_page": "20", "extras": "url_n,count_comments,count_faves" ]
        if let request = Router.getPublicPhotos(parametros).request {
            HttpTask.executeTaskWith(request: request, onComplete: { (data) in
                do {
                    let responsePhotos = try JSONDecoder().decode(ResponsePhotos.self, from: data)
                    completion(responsePhotos.photos, nil)
                } catch {
                    print("getPublicPhotos")
                    return completion(nil, .invalidJSON)
                }
            }, onError: { (error) in completion(nil, error) })
        }
    }
    
    func getInfos(photoId: String, completion: @escaping (PhotoDetail?, ApiError?) -> ()) {
        let parametros = ["photo_id": photoId]
        if let request = Router.getInfos(parametros).request {
            HttpTask.executeTaskWith(request: request, onComplete: { (data) in
                do {
                    let response = try JSONDecoder().decode(ResponsePhotoDetail.self, from: data)
                    completion(response.photo, nil)
                } catch {
                    print("getUserInfo")
                    return completion(nil, .invalidJSON)
                }
            }, onError: { (error) in completion(nil, error) })
        }
    }
    
    func getUserInfo(userId: String, completion: @escaping (Person?, ApiError?) -> ()) {
        let parametros = ["user_id": userId]
        if let request = Router.getUserInfo(parametros).request {
            HttpTask.executeTaskWith(request: request, onComplete: { (data) in
                do {
                    let responsePerson = try JSONDecoder().decode(ResponsePerson.self, from: data)
                    completion(responsePerson.person, nil)
                } catch {
                    print("getUserInfo")
                    return completion(nil, .invalidJSON)
                }
            }, onError: { (error) in completion(nil, error) })
        }
    }
    
    /*
    func getSizes(photoId: String, completion: @escaping ([Size]?, ApiError?)->()) {
        let parametros = ["photo_id": photoId]
        if let request = Router.getSizes(parametros).request {
            HttpTask.executeTaskWith(request: request, onComplete: { (data) in
                do {
                    let responseSizes = try JSONDecoder().decode(ResponseSizes.self, from: data)
                    completion(responseSizes.sizes.size, nil)
                } catch {
                    print("getSizes")
                    return completion(nil, .invalidJSON)
                }
            }, onError: { (error) in completion(nil, error) })
        }
    }
    
    func getFavorites(photoId: String, completion: @escaping (Favorite?, ApiError?) -> ()) {
        let parametros = ["photo_id": photoId]
        if let request = Router.getFavorites(parametros).request {
            HttpTask.executeTaskWith(request: request, onComplete: { (data) in
                do {
                    let responseFavorites = try JSONDecoder().decode(ResponseFavorites.self, from: data)
                    completion(responseFavorites.photo, nil )
                } catch {
                    print("getFavorites")
                    return completion(nil, .invalidJSON)
                }
            }, onError: { (error) in completion(nil, error) })
        }
    }
    */
    
 
    
    
   
}
