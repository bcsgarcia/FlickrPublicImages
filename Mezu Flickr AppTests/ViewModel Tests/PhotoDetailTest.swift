//
//  PhotoDetailTest.swift
//  Mezu Flickr AppTests
//
//  Created by Garcia, Bruno (B.C.) on 18/07/19.
//  Copyright © 2019 Garcia, Bruno (B.C.). All rights reserved.
//

import XCTest
@testable import Mezu_Flickr_App

class PhotoDetailTest: XCTestCase {

    var apiManager: ApiManagerMock?
    var sut: PhotoDetailViewModel?
    var photoId = "48304420787"
    var photoTitle = "motel / route 66. mojave desert, ca. 2014"
    
    override func setUp() {
        apiManager = ApiManagerMock()
        sut = PhotoDetailViewModel(apiManagerService: apiManager!)
    }
    
    override func tearDown() {
        apiManager = nil
        sut = nil
    }
    
    func test_generate_photo_detail_response_mock(){
        let sutResponse = MockHelper.getInfosMock()
        XCTAssertEqual(sutResponse.title._content , photoTitle, "Esperado: '\(photoTitle)' / Encontrado: \(sutResponse.title._content)")
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
        
        sut.fetchData(photoId: photoId)
        apiManager.fetchGetInfosSuccess()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        if let photoDetail = sut.photoDetail {
            XCTAssertEqual(photoDetail.title._content, photoTitle, "Esperado: '\(photoTitle)' / Encontrado: \(photoDetail.title._content)")
        } else {
            XCTFail("photoDetail não deve ser nulo")
        }
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
        
        let expectation = self.expectation(description: "fetchngData")
        sut.showAlertClosure = { expectation.fulfill() }
        
        sut.fetchData(photoId: photoId)
        apiManager.fetchGetInfosFail(error: .noInternetConnection)
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(sut.error, "sut error deve ser .noInernetConnection")
        
    }

    func testPerformanceExample() {
        self.measure {
        }
    }

}
