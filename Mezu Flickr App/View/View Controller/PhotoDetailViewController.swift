//
//  ViewController.swift
//  Mezu Flickr App
//
//  Created by Garcia, Bruno (B.C.) on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    // MARK: - IBOutlet
    
    //Photo
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var lblFavoriteCount: UILabel!
    @IBOutlet weak var ivPhoto: UIImageView!
    
    //Person
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var ivProfile: UIImageView!
    
    //PhotoDetail
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblViewCount: UILabel!
    @IBOutlet weak var lblTags: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    // MARK: - Properties
    var indicator = UIActivityIndicatorView()
    var viewModel = PhotoDetailViewModel()
    var photo: Photo?
    var person: Person?
    
    var checkInternetTimer: Timer!
    let checkInternetTimeInterval : TimeInterval = 3
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navigationController = self.navigationController else { return }
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        ActivityIndicatorManager.initialize(indicator, on: navigationController)
        attemptFetchData()
    }
    
    func setPhotoProperties() {
        guard let photo = self.photo else {
            return
        }
        
        lblCommentCount.text = photo.count_comments
        lblFavoriteCount.text = photo.count_faves
        ivPhoto.loadImageUsingUrlString(urlString: photo.url_n)
    }
    
    func setPersonProperties() {
        guard let person = person else {
            return
        }
        
        lblUsername.text = person.username._content
        ivProfile.layer.cornerRadius = 30.0
        ivProfile.layer.masksToBounds = true
        if let url = person.profileUrl {
            ivProfile.loadImageUsingUrlString(urlString: url)
        }
    }
    
    // MARK: - Fetch Data Function
    func attemptFetchData() {
        
        setPhotoProperties()
        setPersonProperties()
        
        guard let photo = self.photo else { return }
        
        ActivityIndicatorManager.start(indicator)
        
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ?
                ActivityIndicatorManager.start(self.indicator) :
                ActivityIndicatorManager.stop(self.indicator)
        }
        
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                switch error {
                case .noResponse, .noData:
                    AlertHelper.showAlert("No data found", view: self)
                case .noInternetConnection:
                    self.initInternetConnectionCheck()
                    AlertHelper.showAlert("Please check your internet connection", view: self)
                default:
                    print(error)
                }
            }
        }
        
        viewModel.didFinishFetch = {
            DispatchQueue.main.async {
                guard let photoDetail = self.viewModel.photoDetail else {
                    return
                }
                
                self.lblTitle.text = photoDetail.title._content
                self.lblDescription.text = photoDetail.description._content
                self.lblViewCount.text = photoDetail.views
                
                if let timestamp = Double(photoDetail.dates.posted) {
                    self.lblDate.text = "\( timestamp.getDateStringFromUTC() )"
                }
                self.lblTags.text = "Tags: \(photoDetail.tags.tag.map({ return $0.raw }).joined(separator: ", "))"
            }
        }
        
        viewModel.fetchData(photoId: photo.id)
    }
    
    // MARK: - Internet Connection
    func initInternetConnectionCheck(){
        if checkInternetTimer == nil {
            ActivityIndicatorManager.start(indicator)
            checkInternetTimer = Timer.scheduledTimer(timeInterval: checkInternetTimeInterval, target: self, selector: #selector(checkInernet), userInfo: nil, repeats: true)
        }
    }
    
    @objc func checkInernet(){
        if CheckInternet.Connection() {
            checkInternetTimer.invalidate()
            checkInternetTimer = nil
            ActivityIndicatorManager.stop(indicator)
            attemptFetchData()
        }
    }
   
    // MARK: - IBActions
    @IBAction func photoClick(_ sender: Any) {
        let newImageView = UIImageView(image: ivPhoto.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
}

