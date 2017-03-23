//
//  UserViewModel.swift
//  RestfulMobileClient
//
//  Created by Hana  Demas on 3/23/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation
import SwiftyJSON

//URIs to get users
fileprivate let  userUrlPath:String =  "http://jsonplaceholder.typicode.com/users"

class UsersViewModel {
    
    //MARK: Properties
    fileprivate var apiResponse: PlaceholderAPIClient = PlaceholderAPIClient()
    fileprivate var users: [User] = [User]()
    
    //MARK: Custom Functions for parsing network respons into users object array
    func getUsersFromJsonResponse(res: ResponseObject, completion: (() -> ())?){
        for i in 0...(res.count) - 1 {
            let j: JSON = JSON(res[i])
            if  let user: User = User.init(json: j) {
                self.users.append(user)
            }
        }
        if users.count > 1 {
            users.sort {$0.name < $1.name }
        }
        completion?()
    }
    
    //MARK: Custom Functions for feteching data from network and parsing into objects
    func getAllUsersFromAPIResponse(completion: (() -> ())?) {
        apiResponse.fetchDataFromNetwork(url:userUrlPath){ (res) in
            if let res = res {
                self.getUsersFromJsonResponse(res: res , completion: completion)
            } else {
                completion?()
                print("error Fetching data")
            }
        }
    }
    
    //MARK: Custom functions for preparing data to populate UI
    // for Users list table view
    func getNumberOfUsers()->Int{
        return self.users.count
    }
    
    func getuserAtIndex(index:Int )-> User{
        return users[index]
    }
}
