//
//  ViewController.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        ApiManager.findBy(username: "eyetwist", onComplete: { (user) in
            print(user)
        }, onError: { (error) in
            print(error)
        })
        
        ApiManager.getPublicPhotos(userId: "49191827@N00", page: 1, onComplete: { (photos) in
            print("OK")
        }, onError: { (error) in
            print(error)
        })
        */
        self.activityIndicator()
        self.activityIndicatorStart()
        
    }
    
    
    // MARK: - UI Setup
    private func activityIndicatorStart() {
        DispatchQueue.main.async {
            self.indicator.isHidden = false
            self.indicator.startAnimating()
        }
    }
    
    private func activityIndicatorStop() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
        }
    }
    
    func activityIndicator() {
        DispatchQueue.main.async {
            self.indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
            self.indicator.style = UIActivityIndicatorView.Style.whiteLarge
            self.indicator.center = self.view.center
            
            //indicator.hidesWhenStopped = true
            self.view.addSubview(self.indicator)
        }
    }


}

