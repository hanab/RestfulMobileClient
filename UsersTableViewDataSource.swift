//
//  UsersTableViewDataSource.swift
//  RestfulMobileClient
//
//  Created by Hana  Demas on 2/23/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class UsersTableViewDataSource: NSObject,  UITableViewDataSource {
    
    fileprivate let cellIdentifer = "Cell"
    fileprivate let data = UserData()
    override init() {
      data.getAllUsersFromAPIRespons()
        print(data.getNumberOfUsers())
    }
   
    
    func registerCellsForTableView(tableView: UITableView) {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.getNumberOfUsers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
        
        cell.textLabel?.text = data.getuserAtIndex(index: indexPath.row)
        return cell
    }

}
