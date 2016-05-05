//
//  MainViewController.swift
//  CYXSwiftDemo
//
//  Created by Macx on 15/11/7.
//  Copyright © 2015年 cyx. All rights reserved.
//

import UIKit

class MainViewController: AnimationTabBarController,UITabBarControllerDelegate {
    
    private var fristLoadMainTabBarController: Bool = true
    private var adImageView: UIImageView?
    var adImage: UIImage? {
        didSet {
            weak var tmpSelf = self
            adImageView = UIImageView(frame: ScreenBounds)
            adImageView!.image = adImage!
            self.view.addSubview(adImageView!)
            
            UIImageView.animateWithDuration(2.0, animations: { () -> Void in
                tmpSelf!.adImageView!.transform = CGAffineTransformMakeScale(1.2, 1.2)
                tmpSelf!.adImageView!.alpha = 0
            }) { (finsch) -> Void in
                tmpSelf!.adImageView!.removeFromSuperview()
                tmpSelf!.adImageView = nil
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self

        buildMainTabBarChildViewController()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if fristLoadMainTabBarController {
            let containers = createViewContainers()
            
            createCustomIcons(containers)
            fristLoadMainTabBarController = false
        }
    }
    
    // MARK: 初始化tabbar
    private func buildMainTabBarChildViewController() {
        tabBarControllerAddChildViewController(HomeTableViewController(), title: "首页", imageName: "tabbar_home", selectedImageName: "tabbar_home_highlighted", tag: 0)
        tabBarControllerAddChildViewController(MessageTableViewController(), title: "闪电超市", imageName: "tabbar_category", selectedImageName: "tabbar_category_highlighted", tag: 1)
        tabBarControllerAddChildViewController(DiscoverTableViewController(), title: "购物车", imageName: "tabbar_shoppingcart", selectedImageName: "tabbar_shoppingcart_highlighted", tag: 2)
        tabBarControllerAddChildViewController(ProfileTableViewController(), title: "我的", imageName: "tabbar_mine", selectedImageName: "tabbar_mine_highlighted", tag: 3)
    }
    
    private func tabBarControllerAddChildViewController(childView: UIViewController, title: String, imageName: String, selectedImageName: String, tag: Int) {
        let vcItem = RAMAnimatedTabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        vcItem.tag = tag
        vcItem.animation = RAMBounceAnimation()
        childView.tabBarItem = vcItem
        childView.title = title
        let navigationVC = BaseNavigationController(rootViewController:childView)
        addChildViewController(navigationVC)
    }

    
//    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
//        let childArr = tabBarController.childViewControllers as NSArray
//        let index = childArr.indexOfObject(viewController)
//        
//        if index == 2 {
//            return false
//        }
//        
//        return true
//    }
}
