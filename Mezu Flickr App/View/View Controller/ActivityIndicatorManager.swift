//
//  ActivityIndicatorManager.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 17/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatorManager {
    
    // MARK: - UI Setup
    class func start(_ indicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            indicator.isHidden = false
            indicator.startAnimating()
        }
    }
    
    class func stop(_ indicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            indicator.stopAnimating()
        }
    }
    
    class func initialize(_ indicator: UIActivityIndicatorView, on navigationController: UINavigationController) {
        DispatchQueue.main.async {
            //indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
            indicator.style = UIActivityIndicatorView.Style.whiteLarge
            indicator.center = navigationController.view.center
            navigationController.view.addSubview(indicator)
        }
    }
    
}
