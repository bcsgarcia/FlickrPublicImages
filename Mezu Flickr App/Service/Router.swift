//
//  Router.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation


enum ApiError {
    case invalidJSON
    case url
    case noResponse
    case noData
    case httpError(code: Int)
    case noInternetConnection
}

enum FlickrMethods: String {
    case findByUsername = "flickr.people.findByUsername"
    case getPublicPhotos = "flickr.people.getPublicPhotos"
    case getInfos = "flickr.photos.getInfo"
    case getSizes = "flickr.photos.getSizes"
}

/*
 - flickr.people.findByUsername
 - flickr.people.getPublicPhotos
 - flickr.photos.getInfo
 - flickr.photos.getSizes
 method:
 api_key: "7ec9d191b3831b20d5b7695d49db8946"
 format: json
 nojsoncallback: 1
 */

enum Router {
    case findByUsername([String:String])
    case getPublicPhotos([String:String])
    case getInfos([String:String])
    case getSizes([String:String])
    
    // host comum a todos
    var basePath: String {
        return "https://api.flickr.com/services/rest"
    }
    
    // o path que varia de acordo com o case
    /*var path: String {
        switch self {
        case .findByUsername: return "usuarios"
        case .ofertas: return "ofertas"
        case .favoritas: return "ofertas/favoritas"
        }
    }*/
    
    var parametros: [String: Any] {
        
        var params = [  "api_key": "7ec9d191b3831b20d5b7695d49db8946",
                        "format": "json",
                        "nojsoncallback": "1"]
        
        switch self {
            case .findByUsername(let urlParams):
                params["method"] = FlickrMethods.findByUsername.rawValue
                return params.merging(urlParams) { (_, new) in new }
            case .getPublicPhotos(let urlParams):
                params["method"] = FlickrMethods.getPublicPhotos.rawValue
                return params.merging(urlParams) { (_, new) in new }
            case .getInfos(let urlParams):
                params["method"] = FlickrMethods.getInfos.rawValue
                return params.merging(urlParams) { (_, new) in new }
            case .getSizes(let urlParams):
                params["method"] = FlickrMethods.getSizes.rawValue
                return params.merging(urlParams) { (_, new) in new }
        }
    }
    
    var metodo: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    // o request que nos interessa
    var request:URLRequest? {
        
        let baseUrlPath = "\(basePath)/"
        var baseURL = URLComponents(string: baseUrlPath)
        
        
        
        baseURL?.queryItems = parametros.map{ qParamter in
            return URLQueryItem(name: qParamter.key, value: "\(qParamter.value)")
        }
        
        guard
            let url = baseURL?.url else {
                print("Impossível iniciar request com essa url.")
                return nil
        }
        
        
        let request = URLRequest(url: url)
        return request
    }
}
