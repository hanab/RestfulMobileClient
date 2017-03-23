//
//  ViewController.swift
//  RestfulMobileClient
//
//  Created by Hana  Demas on 2/21/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import UIKit
import SwiftyJSON

class UsersViewController: UITableViewController {
    
    //MARK: Properties
    fileprivate let cellIdentifer = "Cell"
    fileprivate let data = UsersViewModel()
    
    //MARK : lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //register tableview
        self.registerCellsForTableView(tableView: tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor(red: 52/255, green: 157/255, blue: 74/255, alpha: 1.0)
        self.title = "Users"
        //fetch data
        data.getAllUsersFromAPIResponse{
           self.tableView.reloadData()
        }
    }
}

//MARK: Tableview datasource and delegate
extension UsersViewController {
    
    //MARK: Datasource
    func registerCellsForTableView(tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.getNumberOfUsers()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
        cell.textLabel?.text = self.data.getuserAtIndex(index: indexPath.row).name
        return cell
    }
    
    //MARK: Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondViewController:UserDetailViewController = UserDetailViewController()
        secondViewController.selectedUser = self.data.getuserAtIndex(index: indexPath.row)
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}
