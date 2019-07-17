//
//  ViewController.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    
    var indicator = UIActivityIndicatorView()
    var viewModel = PhotoDetailViewModel()
    var photo: Photo?
    
    var checkInternetTimer: Timer!
    let checkInternetTimeInterval : TimeInterval = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navigationController = self.navigationController else { return }
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        ActivityIndicatorManager.initialize(indicator: indicator, on: navigationController)
        attemptFetchData()
    }
    
    // MARK: - Fetch Data Function
    func attemptFetchData() {
        
        guard let photo = self.photo else {
            return
        }
        
        ActivityIndicatorManager.start(indicator: indicator)
        
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ?
                ActivityIndicatorManager.start(indicator: self.indicator) :
                ActivityIndicatorManager.stop(indicator: self.indicator)
        }
        
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                switch error {
                case .noResponse, .noData:
                    self.showAlert("Problema ao consultar os repositórios, verifique sua conexão com a internet.")
                case .noInternetConnection:
                    self.initInternetConnectionCheck()
                    self.showAlert("Por favor verifique sua conexão com a internet!")
                default:
                    print(error)
                }
            }
        }
        
        viewModel.didFinishFetch = {
            /*
            self.photoCellViewModel = self.viewModel.photoCellViewModels
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            */
            
            guard let photoDetail = self.viewModel.photoDetail else {
                return
            }
            
            print(photoDetail.description._content)
        }
        
        viewModel.fetchData(photoId: photo.id)
    }
    
    
    func initInternetConnectionCheck(){
        if checkInternetTimer == nil {
            ActivityIndicatorManager.start(indicator: indicator)
            checkInternetTimer = Timer.scheduledTimer(timeInterval: checkInternetTimeInterval, target: self, selector: #selector(checkInernet), userInfo: nil, repeats: true)
        }
    }
    
    @objc func checkInernet(){
        if CheckInternet.Connection() {
            checkInternetTimer.invalidate()
            checkInternetTimer = nil
            ActivityIndicatorManager.stop(indicator: indicator)
            attemptFetchData()
        }
    }
    
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}

