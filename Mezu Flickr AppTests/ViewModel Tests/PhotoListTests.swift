//
//  PhotoListTests.swift
//  Mezu Flickr AppTests
//
//  Created by Garcia, Bruno (B.C.) on 18/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import XCTest
@testable import Mezu_Flickr_App

class PhotoListTests: XCTestCase {

    var apiManager: ApiManagerMock?
    var sut: PhotoListViewModel?
    let username = "eyetwist"
    let photoCount = 20
    
    override func setUp() {
        apiManager = ApiManagerMock()
        sut = PhotoListViewModel(apiManagerService: apiManager!)
    }

    override func tearDown() {
        apiManager = nil
        sut = nil
    }

    func test_generate_photos_response_mock(){
        let sutResponse = MockHelper.getPublicPhotosMock()
        XCTAssertEqual(sutResponse.photo.count, photoCount, "Esperado: \(photoCount) / Encontrado: \(sutResponse.photo.count)")
    }
    
    func test_fetch_data_when_Api_result_is_ok(){
        
        guard let sut = sut else {
            XCTFail("sut não foi inicializado")
            return
        }
        
        guard let apiManager = apiManager else {
            XCTFail("apiManager não foi inicializado")
            return
        }
    
        let expectation = self.expectation(description: "fetchngData")
        sut.didFinishFetch = { expectation.fulfill() }
        
        sut.fetchData()
        apiManager.fetchFindBySuccess()
        apiManager.fetchGetUserInfoSuccess()
        apiManager.fetchGetPublicPhotosSuccess()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        if sut.photoCellViewModels.count > 0 {
            XCTAssertEqual(sut.photoCellViewModels[0].person.username._content , username, "Esperado: '\(username)' / Encontrado \(sut.photoCellViewModels[0].photo.owner)")
            
            XCTAssertEqual(sut.photoCellViewModels.count, 20, "Esperado: \(photoCount) / Encontrado \(sut.photoCellViewModels.count)")
            
        } else {
            XCTFail("photoCellViewModels must have object list")
        }
        
        XCTAssertEqual(Config.sharedInstance.searchUser.username._content, username, "Esperado: '\(username)' / Encontrado: \(Config.sharedInstance.searchUser.username._content)")
        
    }
    
    func test_when_service_fail(){
        
        guard let sut = sut else {
            XCTFail("sut não foi inicializado")
            return
        }
        
        guard let apiManager = apiManager else {
            XCTFail("apiManager não foi inicializado")
            return
        }
        
        let expectation = self.expectation(description: "fetchngDataError")
        sut.showAlertClosure = { expectation.fulfill() }
        
        sut.fetchData()
        
        if Config.sharedInstance.searchUser.nsid == "" {
            apiManager.fetchFindByFail(error: .messageError(message: "User not found"))
            waitForExpectations(timeout: 5, handler: nil)
            XCTAssertNotNil(sut.error, "sut error deve ser 'User not found'.")
        } else {
            apiManager.fetchGetPublicPhotosFail(error: .invalidJSON)
            waitForExpectations(timeout: 5, handler: nil)
            XCTAssertNotNil(sut.error, "sut error deve ser .invalidJson")
        }
    }

    func testPerformanceExample() {
        self.measure {}
    }

}
