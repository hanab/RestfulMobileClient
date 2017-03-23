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
    
    let usersViewModel = UsersViewModel()
    let photosViewModel = PhotosViewModel()
    override func setUp() {
        super.setUp()
    }
    
    func testUsersData() {
        let testExpectation =  expectation(description: "User info expectation")
         usersViewModel.getAllUsersFromAPIResponse{
          testExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        let numberOfUsers = self.usersViewModel.getNumberOfUsers()
        XCTAssert(numberOfUsers == 10, "more or less Users than expected \(numberOfUsers)")
        let user = usersViewModel.getuserAtIndex(index: 3)
        XCTAssert(user.name == "Ervin Howell")
        XCTAssert(user.userName == "Antonette")
        XCTAssert(user.email == "Shanna@melissa.tv")
    }
    
    func testPhotoData() {
        let testExpectation =  expectation(description: "Photos info expectation")
        photosViewModel.getAllPhotosFromAPIResponse{
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        photosViewModel.organizePhotos()
        let numberOfAlbums = self.photosViewModel.getNumberOfAlbums()
        XCTAssert(numberOfAlbums == 100, "more or less albums than expected \(numberOfAlbums)")
        let album1 = photosViewModel.getAlbumAtIndex(index: 0)
        XCTAssert(album1.0 == 1)
        XCTAssert(album1.1 == "http://placehold.it/150/92c952")
        let numberOfPhotsosInAlbum2 = photosViewModel.getNumberOfPhotos(index: 2)
        XCTAssert(numberOfPhotsosInAlbum2 == 50)
        if let albumOneThirdPhoto = photosViewModel.getPhontoOnAlbumAtIndex(albumId: 1, photoID: 2) {
            XCTAssert(albumOneThirdPhoto.title == "officia porro iure quia iusto qui ipsa ut modi")
            XCTAssert(albumOneThirdPhoto.thumbnailUrl == "http://placehold.it/150/24f355")
        }
    }
}
