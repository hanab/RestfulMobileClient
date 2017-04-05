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
}

// MARK: Company struct
struct Company {
    
    //MARK: Properties
    var name: String
    var catchPhrase: String
    var bs: String
    
    //MARK: Init
    init? (json: JSON) {
        let companyName = json["name"].string ?? ""
        let companyCatchPhrase = json["catchPhrase"].string ?? ""
        let companyBS = json["bs"].string ?? ""
        self.name = companyName
        self.bs = companyBS
        self.catchPhrase = companyCatchPhrase
    }
}

//MARK: Address struct
struct Address {
    
    //MARK: Properties
    var street: String
    var suite: String
    var city: String
    var zipCode: String
    var geo:LocationCoordinate

    //MARK: Init
    init? (json: JSON) {
        let cStreet = json["street"].string ?? ""
        let cSuite = json["suite"].string ?? ""
        let cCity = json["city"].string ?? ""
        let cZipCode = json["zipcode"].string ?? ""
        // get location coordinates
        let cGeoLong = json["geo"]["lng"].doubleValue
        let cGeoLati = json["geo"]["lat"].doubleValue
        let geo = LocationCoordinate(cGeoLati, cGeoLong)
        self.street = cStreet
        self.suite = cSuite
        self.city = cCity
        self.zipCode = cZipCode
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
        //Address JSON object
        let addressJson = json["address"] as JSON
        //Company JSON object
        let companyJson = json["company"] as JSON
        //Construct user object
        self.id = id
        self.name = name ?? ""
        self.userName = userName ?? ""
        self.email = email ?? ""
        if let company = Company(json: companyJson){
            self.company = company
        }
        guard let company = Company(json: companyJson) else {
            return nil
        }
        self.company = company
        guard let address = Address(json: addressJson) else  {
            return nil
        }
        self.address = address
        self.website = website ?? ""
        self.phone = phone ?? ""
    }
}
