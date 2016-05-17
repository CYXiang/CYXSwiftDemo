//
//  SelectedAressViewController.swift
//  CYXSwiftDemo
//
//  Created by apple开发 on 16/5/6.
//  Copyright © 2016年 cyx. All rights reserved.
//

import UIKit
import SVProgressHUD

class SelectedAressViewController: AnimationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Creat UI
    private func setUpNavigationItem(){
    
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton("扫一扫", titleColor: UIColor.blackColor(), image: UIImage(named: "icon_black_scancode")!, hightLightImage: nil, target: self, action: #selector(SelectedAressViewController.leftItemClick), type: ItemButtonType.Left)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton("搜索", titleColor: UIColor.blackColor(), image: UIImage(named: "icon_search")!, hightLightImage: nil, target: self, action: #selector(SelectedAressViewController.rightItemClick), type: ItemButtonType.Right)
    }
    
    // MARK: - Action
    // MARK: 扫一扫
    func leftItemClick() {
         SVProgressHUD.showSuccessWithStatus("扫描成功")
        
        
    }
    //
    func rightItemClick() {
        let searchVC = SearchProductViewController()
        navigationController?.pushViewController(searchVC, animated: true)
        
    }
    
    func titleViewClick() {
        
    }
}
