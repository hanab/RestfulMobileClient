//
//  UserDetailViewController.swift
//  RestfulMobileClient
//
//  Created by Hana  Demas on 2/28/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import UIKit
import Foundation

// protocol implmented by view controller to desplay an alertview when button is clicked
protocol AlertViewDelegate {
    
    func show()
}

class UserDetailViewController: UIViewController, AlertViewDelegate {
    
    //MARK: Properties
    fileprivate var companyInfo:String = ""
    // data passed from another viewcontroller
    var selectedUser: User?
    var subView: CustomView!

    //MARK: View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brown
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.subView = CustomView(frame: self.view.frame)
        if let  userame = selectedUser?.userName {
            subView.username =  userame
        }
        if let  name = selectedUser?.name {
            subView.name =  "Name: \(name)"
        }
        if let  email = selectedUser?.email {
            subView.email =  "Email: \(email)"        }
        if let  phone = selectedUser?.phone {
            subView.phone =  "Phone: \(phone)"
        }
        if let  street = selectedUser?.address.street {
            if let city = selectedUser?.address.city {
                subView.address = "Address: " + street + ", " + city
            }
        }
        if let companyName = selectedUser?.company.name {
            subView.companyName = "Company: \(companyName)"
        }
        if let catchPhrase = selectedUser?.company.catchPhrase {
            if let bs  = selectedUser?.company.bs {
             self.companyInfo = "Catch phrase: " + catchPhrase + "\n" + "BS: " + bs
            }
        }
        subView.delegate = self
        self.view.addSubview(subView)
    }
    
    //redraw View when screen rottates
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.subView.frame  = self.view.frame
    }

    //MARK: AlertViewDelegate implementation
    func show() {
        let alertController = UIAlertController(title: "CompanyInfo", message: companyInfo, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true)
    }
}
