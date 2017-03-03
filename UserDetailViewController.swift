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
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var subView: CustomView!

    //MARK: View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brown
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.subView = CustomView(frame: self.view.frame)
        if let  userame = appDelegate.selectedUser?.userName {
            subView.username =  userame
        }
        if let  name = appDelegate.selectedUser?.name {
            subView.name =  "Name: \(name)"
        }
        if let  email = appDelegate.selectedUser?.email {
            subView.email =  "Email: \(email)"        }
        if let  phone = appDelegate.selectedUser?.phone {
            subView.phone =  "Phone: \(phone)"
        }
        if let  street = appDelegate.selectedUser?.address.street {
            if let city = appDelegate.selectedUser?.address.city {
                subView.address = "Address: " + street + ", " + city
            }
        }
        if let companyName = appDelegate.selectedUser?.company.name {
            subView.companyName = "Company: \(companyName)"
        }
        if let catchPhrase = appDelegate.selectedUser?.company.catchPhrase {
            if let bs  = appDelegate.selectedUser?.company.bs {
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
