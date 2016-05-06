//
//  ADViewController.swift
//  CYXSwiftDemo
//
//  Created by apple开发 on 16/5/5.
//  Copyright © 2016年 cyx. All rights reserved.
//

import UIKit

class ADViewController: UIViewController {

    /// 图片
    private lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.frame = ScreenBounds
        return backImageView
    }()
    
    var imageName: String?{
        didSet{
            var placeholderImageName: String?
            switch UIDevice.currentDeviceScreenMeasurement() {
            case 3.5:
                placeholderImageName = "iphone4"
            case 4.0:
                placeholderImageName = "iphone5"
            case 4.7:
                placeholderImageName = "iphone6"
            default:
                placeholderImageName = "iphone6s"
            }
            backImageView.sd_setImageWithURL(NSURL(string: imageName!), placeholderImage: UIImage(named:placeholderImageName!)) { (image, error, _, _) -> Void in
                if error != nil {
                    print("加载广告失败")
                    NSNotificationCenter.defaultCenter().postNotificationName(ADImageLoadFail, object: nil)
                }
                if image != nil {
                    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
                    
                    dispatch_after(time, dispatch_get_main_queue(), { 
                        NSNotificationCenter.defaultCenter().postNotificationName(ADImageLoadSecussed, object: image)
                    })
                    
                } else {
                    //加载广告失败
                    print("加载广告失败")
                    NSNotificationCenter.defaultCenter().postNotificationName(ADImageLoadFail, object: nil)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backImageView)
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .None)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
