//
//  AlertHelper.swift
//  Mezu Flickr App
//
//  Created by Bruno Garcia on 17/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import Foundation
import UIKit

class AlertHelper {
    
    class func showAlert(_ message: String, view: UIViewController) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
}
