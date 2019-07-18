//
//  PhotoTableViewController.swift
//  Mezu Flickr App
//
//  Created by Bruno Garcia on 16/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import UIKit

class PhotoTableViewController: UITableViewController {

    var viewModel = PhotoListViewModel()
    var photoCellViewModel = [PhotoCellViewModel]()
    var indicator = UIActivityIndicatorView()
    
    var checkInternetTimer: Timer!
    let checkInternetTimeInterval : TimeInterval = 3
    let cellId = "photoCell"
    let segueIdentifier = "segueDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //activityIndicator()
        
        guard let navigationController = self.navigationController else { return }
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        ActivityIndicatorManager.initialize(indicator, on: navigationController)
        
        attemptFetchData()
        
        print(Config.sharedInstance.searchUser.nsid == "")
        
    }
    
    // MARK: - Fetch Data Function
    func attemptFetchData() {
        //self.activityIndicatorStart()
        ActivityIndicatorManager.start(indicator)
        
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ?
                ActivityIndicatorManager.start(self.indicator) :
                ActivityIndicatorManager.stop(self.indicator) }
        
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                switch error {
                case .noResponse, .noData:
                    AlertHelper.showAlert("Problema ao consultar os repositórios, verifique sua conexão com a internet.", view: self)
                case .noInternetConnection:
                    self.initInternetConnectionCheck()
                    AlertHelper.showAlert("Por favor verifique sua conexão com a internet!", view: self)
                case .messageError(let message):
                    AlertHelper.showAlert(message, view: self)
                default:
                    print(error)
                }
            }
        }
        
        viewModel.didFinishFetch = {
            self.photoCellViewModel = self.viewModel.photoCellViewModels
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.didFinishUserFetch = {
            DispatchQueue.main.async {
                
                if let realname = Config.sharedInstance.searchPerson.realname {
                    if realname._content != "" {
                        self.title = "Flickr - \(realname._content)"
                        return
                    }
                }
                
                self.title = "Flickr - \(Config.sharedInstance.searchPerson.username._content)"
                
                
            }
        }
        
        viewModel.fetchData()
    }
    
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
            //activityIndicatorStop()
            ActivityIndicatorManager.stop(indicator)
            attemptFetchData()
        }
    }
    
    // MARK: - UI Setup
    /*
    private func activityIndicatorStart() {
        DispatchQueue.main.async {
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
            self.indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            self.indicator.style = UIActivityIndicatorView.Style.whiteLarge
            self.indicator.color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            self.indicator.center = self.view.center
            self.navigationController?.view.addSubview(self.indicator)
        }
     }
 
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
 */
    
    
    @IBAction func searchClick(_ sender: Any) {
        
        let alert = UIAlertController(title: "Search Flickr User", message: "Enter a Username", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = Config.sharedInstance.searchUser.username._content
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            if let username = textField?.text {
                self.viewModel.fetchUser(username: username)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}



//TableViewDataSource extension func
extension PhotoTableViewController {
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoCellViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PhotoCell else {
            return UITableViewCell()
        }
        
        let photoCellViewModel = self.photoCellViewModel[indexPath.row]
        cell.photoCellViewModel = photoCellViewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = photoCellViewModel[indexPath.row]
        performSegue(withIdentifier: self.segueIdentifier, sender: vm)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueIdentifier {
            if let photoDetailVC = segue.destination as? PhotoDetailViewController{
                guard let photoCellViewModel = sender as? PhotoCellViewModel else { return }
                photoDetailVC.photo = photoCellViewModel.photo
                photoDetailVC.person = photoCellViewModel.person
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.photoCellViewModels.count-2 {
            self.attemptFetchData()
        }
    }
    
}
