//
//  AppDelegate.swift
//  CYXSwiftDemo
//
//  Created by Macx on 15/11/6.
//  Copyright © 2015年 cyx. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var adViewController: ADViewController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        setAppSubject()
        
        addNotification()
        
        buildKeyWindow()
        
        return true
    }
    // 析构函数
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func addNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.showMainTabbarControllerSucess(_:)), name: ADImageLoadSecussed, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.showMainTabbarControllerFale), name: ADImageLoadFail, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.shoMainTabBarController), name: GuideViewControllerDidFinish, object: nil)
    }
    
    // MARK: - Action
    func showMainTabbarControllerSucess(noti: NSNotification) {
        let adImage = noti.object as! UIImage
        let mainTabBar = MainViewController()
        mainTabBar.adImage = adImage
        window?.rootViewController = mainTabBar
    }
    
    func showMainTabbarControllerFale() {
        window!.rootViewController = MainViewController()
    }
    
    func shoMainTabBarController() {
        window!.rootViewController = MainViewController()
    }


    
    // MARK: - privete Method
    // 初始化窗口
    private func buildKeyWindow(){
    
//        // 设置图片
//        UITabBar.appearance().tintColor = UIColor.blackColor()
//        
//        // 1.创建window
//        window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        // 2.设置根控制器
//        window?.rootViewController = MainViewController()
//        // 3.显示window
//        window?.makeKeyAndVisible()
        
        window = UIWindow(frame: ScreenBounds)
        window!.makeKeyAndVisible()
        
        if isNewVersion() {
            window?.rootViewController = GuideViewController()
            NSUserDefaults.standardUserDefaults().setObject("isFristOpenApp", forKey: "isFristOpenApp")
        }else{
            loadADRootViewController()
        }
        
    }
    
    func loadADRootViewController() {
        adViewController = ADViewController()
        
        weak var tmpSelf = self
        MainAD.loadADData { (data, error) in
            if data?.data?.img_name != nil {
                tmpSelf!.adViewController!.imageName = data!.data!.img_name
                tmpSelf!.window?.rootViewController = self.adViewController
            }
        }
    }
    
    // MARK: 主题设置
    private func setAppSubject() {
        UITabBar.appearance().tintColor = UIColor.blackColor()

        let tabBarAppearance = UITabBar .appearance()
        tabBarAppearance.backgroundColor = UIColor.whiteColor()
        
        let navBarnAppearance = UINavigationBar.appearance()
        navBarnAppearance.translucent = false
    }
    
    // MARK: 检测新版本
    private func isNewVersion() -> Bool
    {
        // 1.从info.plist中获取当前软件的版本号
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        
        // 2.从沙盒中获取以前的软件版本号
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let sanboxVersion = (userDefaults.objectForKey("CFBundleShortVersionString") as? String) ?? "0.0"
        
        // 3.利用"当前的"和"沙盒的"进行比较
        // 如果当前的 > 沙盒的, 有新版本
        // 1.0 0.0
        if currentVersion.compare(sanboxVersion) == NSComparisonResult.OrderedDescending
        {
            // 有新版本
            // 4.存储当前的软件版本号到沙盒中
            userDefaults.setObject(currentVersion, forKey: "CFBundleShortVersionString")
            userDefaults.synchronize() // iOS7以前需要这样做, iOS7以后不需要了
            return true
        }
        
        // 5.返回结果
        return false
        
    }

}


/**
 自定义LOG的目的
 在开发阶段自动显示LOG
 在发布阶段自动屏蔽LOG
 
 print(__FUNCTION__)  // 打印所在的方法
 print(__LINE__)     // 打印所在的行
 print(__FILE__)     // 打印所在文件的路径
 */
func CYXLog<T>(message : T, method :String = __FUNCTION__, line : Int = __LINE__){

    #if DEBUG
    print("\(method)[\(line)]:\(message)")
    #endif
    
}

