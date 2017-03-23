//
//  CustomView.swift
//  RestfulMobileClient
//
//  Created by Hana  Demas on 2/28/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CustomView: UIView {
    
    // MARK: subviews
    private lazy var leftView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    private lazy var rightView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.italicSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var profilePic: UIImageView = {
        let profilePic = UIImageView(image: UIImage(named: "profilePic.png"))
        return profilePic
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 1
        nameLabel.text = "Name: "
        nameLabel.font = UIFont.italicSystemFont(ofSize: 12)
        return nameLabel
    }()
    
    private lazy var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.numberOfLines = 3
        emailLabel.text = "Email: "
        emailLabel.font = UIFont.italicSystemFont(ofSize: 12)
        return emailLabel
    }()
    
    private lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.numberOfLines = 3
        phoneLabel.text = "Phone"
        phoneLabel.font = UIFont.italicSystemFont(ofSize: 12)
        return phoneLabel
    }()
    
    private lazy var companyNameLabel: UILabel = {
        let companyNameLabel = UILabel()
        companyNameLabel.numberOfLines = 3
        companyNameLabel.text = "Company: "
        companyNameLabel.font = UIFont.italicSystemFont(ofSize: 12)
        return companyNameLabel
    }()
    
    private lazy var companyView: UIView = {
        let companyView = UIView()
        return companyView
    }()
    
    private lazy var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.numberOfLines = 1
        addressLabel.text = "Address: "
        addressLabel.font = UIFont.italicSystemFont(ofSize: 12)
        return addressLabel
    }()
    
    private lazy var comapnyInfoBtn: UIButton = {
        let comapnyInfoBtn = UIButton()
        comapnyInfoBtn.setTitle("Info", for: UIControlState.normal)
        comapnyInfoBtn.setImage(UIImage(named: "info.png"), for: UIControlState())
        comapnyInfoBtn.addTarget(self, action: #selector(showCompanyInfo), for: .touchUpInside)
        return comapnyInfoBtn
    }()
    
    //MARK: Properties
    var delegate: AlertViewDelegate?
    var username: String? {
        didSet {
            self.usernameLabel.text = username
        }
    }
    var name: String? {
        didSet {
            self.nameLabel.text = name
        }
    }
    var email: String? {
        didSet {
            self.emailLabel.text = email
        }
    }
    var phone: String? {
        didSet {
            self.phoneLabel.text = phone
        }
    }
    var address: String? {
        didSet {
            self.addressLabel.text = address       }
    }
    var companyName: String? {
        didSet {
            self.companyNameLabel.text = companyName
        }
    }
   
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        //add subviews
        self.addSubview(leftView)
        self.addSubview(rightView)
        leftView.addSubview(profilePic)
        leftView.addSubview(usernameLabel)
        rightView.addSubview(nameLabel)
        rightView.addSubview(emailLabel)
        rightView.addSubview(phoneLabel)
        rightView.addSubview(companyView)
        rightView.addSubview(addressLabel)
        companyView.addSubview(companyNameLabel)
        companyView.addSubview(comapnyInfoBtn)
        //add constraints
        addConstraintToContainerSubViews()
        addConstraintsToLeftView()
        addConstraintsToRightView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //MARK: Button Action
    func showCompanyInfo() {
       delegate?.show()
    }
    
    //MARK: custom methods to add constraints
    func addConstraintToContainerSubViews() {
        leftView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(80)
            make.left.equalTo(0)
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
        rightView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(80)
            make.right.equalTo(-20)
            make.width.equalTo(self.snp.width).multipliedBy(0.67)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
    }
    
    func addConstraintsToLeftView() {
        profilePic.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(leftView.snp.top)
            make.centerX.equalTo(leftView.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        usernameLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(leftView.snp.centerX)
            make.top.equalTo(profilePic.snp.bottom).offset(20)
        }
    }
    
    func addConstraintsToRightView() {
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(rightView.snp.left).offset(20)
        }
        emailLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.left.equalTo(rightView.snp.left).offset(20)
        }
        phoneLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.left.equalTo(rightView.snp.left).offset(20)
        }
        companyView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(phoneLabel.snp.bottom)
            make.left.equalTo(rightView.snp.left).offset(20)
            make.width.equalTo(rightView.snp.width)
            make.height.equalTo(40)
        }
        addressLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(companyView.snp.bottom)
            make.left.equalTo(rightView.snp.left).offset(20)
        }
        companyNameLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(companyView.snp.left)
            make.centerY.equalTo(companyView.snp.centerY)
        }
        comapnyInfoBtn.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(companyView.snp.right).offset(-20)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalTo(companyView.snp.centerY)
        }
    }
}
