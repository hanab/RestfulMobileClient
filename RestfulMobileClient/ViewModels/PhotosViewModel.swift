//
//  PhotosViewModel.swift
//  RestfulMobileClient
//
//  Created by Hana  Demas on 3/23/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation
import SwiftyJSON

//URIs to get photos
fileprivate let  photoUrlPath: String = "http://jsonplaceholder.typicode.com/photos"

class PhotosViewModel {
    
    //MARK: Properties
    fileprivate var apiResponse: PlaceholderAPIClient = PlaceholderAPIClient()
    fileprivate var photos: [Photo] = [Photo]()
    //properies used to group photos into album
    fileprivate var fotosById: [Int: [Photo]] = [Int: [Photo]]()
    fileprivate var organizedPhotos: [Int: String] = [Int: String]()
    fileprivate var albumKeys: [Int] = [Int]()
    fileprivate var photosKeys: [Int] = [Int]()
    
    //MARK: Custom Functions for parsing network respons into photos object array
    func getPhotosFromJsonResponse(res: ResponseObject, completion: (() -> ())?){
        for i in 0...(res.count) - 1 {
            let j: JSON = JSON(res[i])
            if let photo: Photo = Photo.init(json: j) {
                self.photos.append(photo)
            }
        }
        completion?()
    }
    
    //MARK: Custom Functions for feteching data from network and parsing into objects
    func getAllPhotosFromAPIResponse(completion: (() -> ())?) {
        apiResponse.fetchDataFromNetwork(url:photoUrlPath){ (res) in
            if let res = res {
                self.getPhotosFromJsonResponse(res: res, completion: completion)
            } else {
                completion?()
                print("error Fetching data")
            }
        }
    }
    
    //MARK: Custom functions for preparing data to populate UI
    //get number of photos in an album
    func getNumberOfPhotos(index:Int)->Int{
        var count: Int = 0
        self.photosKeys = Array(fotosById.keys)
        if(self.photosKeys.contains(index)) {
            if let album = self.fotosById[index]{
                count = album.count
            }
            return count
        } else {
            return 0
        }
    }
    
    //get a photo at index for a given album
    func getPhontoOnAlbumAtIndex(albumId:Int, photoID:Int)-> Photo? {
        let photos = self.fotosById[albumId]
        if photoID < self.getNumberOfPhotos(index: albumId){
            return photos?[photoID]
        }
        return nil
    }
    
    func getNumberOfAlbums() ->Int {
        self.albumKeys = Array(organizedPhotos.keys)
        self.albumKeys.sort{$0 < $1}
        return self.albumKeys.count
    }
    
    func getAlbumAtIndex(index: Int) -> (Int,String){
        let albumId = albumKeys[index]
        let image = self.organizedPhotos[albumId]
        return(albumId, image ?? "")
    }
    
    //group photos into albums
    func organizePhotos (){
        self.fotosById = self.photos.group {$0.albumId}
        for album in self.fotosById {
            self.organizedPhotos[album.key] = album.value[0].thumbnailUrl
        }
    }
}
