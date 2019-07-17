//
//  HttpTask.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation


class HttpTask {
    class func executeTaskWith(request: URLRequest, onComplete: @escaping (Data)->Void, onError: @escaping (ApiError)->Void){
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                return onError(.noResponse)
            } else {
                guard let response = response as? HTTPURLResponse else {
                    return onError(.noResponse)
                }
                switch response.statusCode {
                case 200...299:
                    guard let data = data else {
                        return onError(.noData)
                    }
                    onComplete(data)
                default:
                    return onError(.httpError(code: response.statusCode))
                }
            }
        }
        task.resume()
    }
}
