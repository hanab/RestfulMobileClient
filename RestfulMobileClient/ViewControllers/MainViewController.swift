//
//  MainViewController.swift
//  RestfulMobileClient
//
//  Created by Hana  Demas on 2/23/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        //add viewcontrollers to the tab bar
        let userTab = UsersViewController()
        let userTabBarItem = UITabBarItem(title: "Users", image: UIImage(named: "users.png"), selectedImage: UIImage(named: "users.png"))
        userTab.tabBarItem = userTabBarItem
        let photoTab = PhotosViewController()
        let photoTabBarItem = UITabBarItem(title: "Photos", image: UIImage(named: "photos.png"), selectedImage: UIImage(named: "photos.png"))
        photoTab.tabBarItem = photoTabBarItem
        //add navigationcontroller to viewcontrollers
        let userNavigationController = UINavigationController(rootViewController: userTab)
        userNavigationController.navigationBar.barTintColor =  UIColor(red: 52/255, green: 157/255, blue: 74/255, alpha: 1.0)
        let photoNavigationController = UINavigationController(rootViewController: photoTab)
        photoNavigationController.navigationBar.barTintColor =  UIColor(red: 52/255, green: 157/255, blue: 74/255, alpha: 1.0)
        //add navigation controllers to the tab bar controller
        self.viewControllers = [userNavigationController, photoNavigationController]
    }
}
