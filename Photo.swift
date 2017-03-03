//
//  Photos.swift
//  RestfulMobileClient
//
//  Created by Hana  Demas on 3/1/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Photo {
    
    //MARK: Properties
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
    
    //MARK: Init
    init(albumId:Int, id:Int,title: String, url:String, thumbnailUrl: String) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}

//MARK: get Photos object 
extension Photo {
    
    //MARK: Init
    init?(json: JSON) {
        let albumId = json["albumId"].intValue
        let id = json["id"].intValue
        let title = json["title"].string ?? ""
        let url = json["url"].string ?? ""
        let thumbnailUrl = json["thumbnailUrl"].string ?? ""
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}
