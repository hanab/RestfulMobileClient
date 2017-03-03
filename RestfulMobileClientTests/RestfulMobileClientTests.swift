//
//  RestfulMobileClientTests.swift
//  RestfulMobileClientTests
//
//  Created by Hana  Demas on 2/21/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import RestfulMobileClient

class RestfulMobileClientTests: XCTestCase {
    //let apiClient = PlaceholderAPIClient()
    let viewModel = ViewModel()
    override func setUp() {
        super.setUp()
        
        
    }
    
    func testUsersData() {
        let testExpectation =  expectation(description: "User info expectation")
         viewModel.getAllUsersFromAPIResponse{
          testExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        let numberOfUsers = self.viewModel.getNumberOfUsers()
        XCTAssert(numberOfUsers == 10, "more or less Users than expected \(numberOfUsers)")
        let user = viewModel.getuserAtIndex(index: 3)
        XCTAssert(user.name == "Ervin Howell")
        XCTAssert(user.userName == "Antonette")
        XCTAssert(user.email == "Shanna@melissa.tv")
    }
    
    func testPhotoData() {
        let testExpectation =  expectation(description: "Photos info expectation")
        viewModel.getAllPhotosFromAPIResponse{
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        viewModel.organizePhotos()
        let numberOfAlbums = self.viewModel.getNumberOfAlbums()
        XCTAssert(numberOfAlbums == 100, "more or less albums than expected \(numberOfAlbums)")
        let album1 = viewModel.getAlbumAtIndex(index: 0)
        XCTAssert(album1.0 == 1)
        XCTAssert(album1.1 == "http://placehold.it/150/30ac17")
        let numberOfPhotsosInAlbum2 = viewModel.getNumberOfPhotos(index: 2)
        XCTAssert(numberOfPhotsosInAlbum2 == 50)
        let albumOneThirdPhoto = viewModel.getPhontoOnAlbumAtIndex(albumId: 1, photoID: 2)
        XCTAssert(albumOneThirdPhoto?.title == "officia porro iure quia iusto qui ipsa ut modi")
        XCTAssert(albumOneThirdPhoto?.thumbnailUrl == "http://placehold.it/150/1941e9")
    }
}
