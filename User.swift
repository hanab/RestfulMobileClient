//
//  Users.swift
//  RestfulMobileClient
//
//  Created by Hana  Demas on 2/21/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ResponseObject = [AnyObject]
typealias LocationCoordinate  = (latitude: Double, longitude: Double)

struct User {
    
    //MARK: Properties
    var id: Int
    var name: String
    var userName: String
    var email: String
    var company: Company
    var address: Address
    var website: String
    var phone: String
    
    //MARK: Init
    init(id: Int, name: String, userName: String, email: String, company: Company, address: Address, website:String, phone: String ) {
        
        self.id = id
        self.name = name
        self.userName = userName
        self.email = email
        self.company = company
        self.address = address
        self.website = website
        self.phone = phone
    }
}

// MARK: Company struct
struct Company {
    
    //MARK: Properties
    var name: String
    var catchPhrase: String
    var bs: String
    
    //MARK: Init
    init(name:String, catchPhrase: String, bs:String) {
       self.name = name
       self.catchPhrase = catchPhrase
       self.bs = bs
    }
}

//MARK: Address struct
struct Address {
    
    var street: String
    var suite: String
    var city: String
    var zipCode: String
    var geo:LocationCoordinate

    //MARK: Init
    init(street: String, suite: String, city: String, zipCode: String, geo:LocationCoordinate) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipCode = zipCode
        self.geo = geo
    }
}

//MARK: User object construction from JSON
extension User {
    
    //MARK: Init
    init?(json: JSON) {
        let id = json["id"].intValue
        let name = json["name"].string
        let userName = json["username"].string
        let email = json["email"].string
        let website = json["website"].string
        let phone = json["phone"].string
        // construct address object
        let cStreet = json["address"]["street"].string ?? ""
        let cSuite = json["address"]["suite"].string ?? ""
        let cCity = json["address"]["city"].string ?? ""
        let cZipCode = json["address"]["zipcode"].string ?? ""
        // get location coordinates
        let cGeoLong = json["address"]["geo"]["lng"].doubleValue
        let cGeoLati = json["address"]["geo"]["lat"].doubleValue
        let geo = LocationCoordinate(cGeoLati, cGeoLong)
        let address = Address(street: cStreet, suite: cSuite, city: cCity, zipCode: cZipCode, geo: geo)
        //consrtuct Company
        let companyName = json["company"]["name"].string ?? ""
        let companyCatchPhrase = json["company"]["catchPhrase"].string ?? ""
        let companyBS = json["company"]["bs"].string ?? ""
        let companyInfo = Company(name: companyName, catchPhrase: companyCatchPhrase, bs: companyBS)
        //construct User
        self.id = id
        self.name = name ?? ""
        self.userName = userName ?? ""
        self.email = email ?? ""
        self.company = companyInfo
        self.address = address
        self.website = website ?? ""
        self.phone = phone ?? ""
    }
}
