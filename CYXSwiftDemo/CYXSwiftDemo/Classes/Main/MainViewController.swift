//
//  MainViewController.swift
//  CYXSwiftDemo
//
//  Created by Macx on 15/11/7.
//  Copyright © 2015年 cyx. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()


//        // 1.创建子控制器
//        let homeVC = HomeTableViewController()
//        homeVC.tabBarItem.image = UIImage(named: "tabbar_home")
//        homeVC.title = "首页"
//        homeVC.tabBarItem.selectedImage = UIImage(named: "tabbar_home_highlighted")
//        // 2.包装一个导航控制器
//        let nav = UINavigationController(rootViewController: homeVC)
//        
//        // 3.将导航控制器添加到UITabBarController
//        addChildViewController(nav)
        
        addChildViewController(HomeTableViewController(), imageName: "tabbar_home", title: "首页")
        addChildViewController(MessageTableViewController(), imageName: "tabbar_message_center", title: "消息")
        addChildViewController(DiscoverTableViewController(), imageName: "tabbar_discover", title: "广场")
        addChildViewController(ProfileTableViewController(), imageName: "tabbar_profile", title: "我")
    }


    func addChildViewController(childController: UIViewController ,imageName:String, title:String) {

        childController.tabBarItem.image = UIImage(named:imageName)
        childController.title = title
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        // 2.包装一个导航控制器
        let nav1 = UINavigationController(rootViewController: childController)
        
        // 3.将导航控制器添加到UITabBarController
        addChildViewController(nav1)
    }
}
