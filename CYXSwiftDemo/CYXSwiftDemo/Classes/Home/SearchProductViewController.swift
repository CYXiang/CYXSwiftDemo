//
//  SearchProductViewController.swift
//  CYXSwiftDemo
//
//  Created by apple开发 on 16/5/6.
//  Copyright © 2016年 cyx. All rights reserved.
//

import UIKit

class SearchProductViewController: AnimationViewController {

    private let contentScrollView = UIScrollView(frame: ScreenBounds)
    private let searchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSearchBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Creat UI 
    private func setUpSearchBar(){
    
        (navigationController as! BaseNavigationController).backBtn.frame = CGRectMake(0, 0, 10, 40)
        
        let tmpView = UIView(frame: CGRectMake(0, 0, ScreenWidth * 0.8, 30))
        tmpView.backgroundColor = UIColor.whiteColor()
        tmpView.layer.masksToBounds = true
        tmpView.layer.cornerRadius = 6
        tmpView.layer.borderColor = UIColor(red: 100 / 255.0, green: 100 / 255.0, blue: 100 / 255.0, alpha: 1).CGColor
        tmpView.layer.borderWidth = 0.2
        let image = UIImage.createImageFromView(tmpView)
        
        searchBar.frame = CGRectMake(0, 0, ScreenWidth * 0.9, 30)
        searchBar.placeholder = "请输入商品名称"
        searchBar.barTintColor = UIColor.whiteColor()
        searchBar.keyboardType = UIKeyboardType.Default
        searchBar.setSearchFieldBackgroundImage(image, forState: .Normal)
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        
        let navVC = navigationController as! BaseNavigationController
        let leftBtn = navigationItem.leftBarButtonItem?.customView as? UIButton
        leftBtn!.addTarget(self, action: #selector(SearchProductViewController.leftButtonClcik), forControlEvents: UIControlEvents.TouchUpInside)
        navVC.isAnimation = false
    }
    
    func leftButtonClcik() {
        searchBar.endEditing(false)
    }
    
    

}


extension SearchProductViewController: UISearchBarDelegate, UIScrollViewDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        if searchBar.text?.characters.count > 0 {
            
//            writeHistorySearchToUserDefault(searchBar.text!)
            
//            loadProductsWithKeyword(searchBar.text!)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        searchBar.endEditing(false)
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count == 0 {
//            searchCollectionView?.hidden = true
//            yellowShopCar?.hidden = true
        }
    }
}
