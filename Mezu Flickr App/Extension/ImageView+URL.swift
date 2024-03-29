//
//  ImageView+URL.swift
//  Mezu Flickr App
//
//  Created by Bruno Garcia on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation
import UIKit


let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingUrlString(urlString: String) {
        DispatchQueue.main.async {
            self.image = #imageLiteral(resourceName: "flickr-icon-logo.png")    
        }
        
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        if let url = URL(string: urlString) {
            DispatchQueue.global().async { //[weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            //let cacheImage = image
                            //imageCache.setObject(image, forKey: urlString as AnyObject)
                            self.image = image
                            
                        }
                    }
                }
            }
        }
    }
}

