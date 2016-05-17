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
    private var hotSearchView: SearchView?
    private var historySearchView: SearchView?
    private var cleanHistoryButton: UIButton = UIButton()
    private var searchCollectionView: LFBCollectionView?
    private var goodses: [Goods]?
    private var yellowShopCar: YellowShopCarView?
    private var collectionHeadView: NotSearchProductsView?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSearchBar()
        
        setUpContentScrollView()
        
        setUpCleanHistorySearchButton()
        
        setUpHotSearchButtonData()
        
        loadHistorySearchButtonData()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Creat UI 
    
    private func setUpContentScrollView() {
        contentScrollView.backgroundColor = view.backgroundColor
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.delegate = self
        contentScrollView.contentSize = CGSizeMake(ScreenWidth, 1000)

        view.addSubview(contentScrollView)
    }
    
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
        
        
//        let navVC = navigationController as! BaseNavigationController
        let leftBtn = navigationItem.leftBarButtonItem?.customView as? UIButton
        leftBtn!.addTarget(self, action: #selector(SearchProductViewController.leftButtonClcik), forControlEvents: UIControlEvents.TouchUpInside)
//        navVC.isAnimation = false
    }
    
    private func setUpHotSearchButtonData(){
    
        var array: [String]?
        var historySearch = NSUserDefaults.standardUserDefaults().objectForKey(LFBSearchViewControllerHistorySearchArray) as? [String]
        
        if historySearch == nil {
            historySearch = [String]()
            NSUserDefaults.standardUserDefaults().setObject(historySearch, forKey: LFBSearchViewControllerHistorySearchArray)
        }
        weak var tmpSelf = self
        let pathStr = NSBundle.mainBundle().pathForResource("SearchProduct", ofType: nil)
        let data = NSData(contentsOfFile: pathStr!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            array = (dict.objectForKey("data")! as! NSDictionary).objectForKey("hotquery") as? [String]
            if array?.count > 0 {
                hotSearchView = SearchView(frame: CGRectMake(10, 20, ScreenWidth - 20, 100), searchTitleText: "热门搜索", searchButtonTitleTexts: array!) { (sender) -> () in
                    let str = sender.titleForState(UIControlState.Normal)
                    tmpSelf!.writeHistorySearchToUserDefault(str!)
                    tmpSelf!.searchBar.text = sender.titleForState(UIControlState.Normal)
                    tmpSelf!.loadProductsWithKeyword(sender.titleForState(UIControlState.Normal)!)
                }
                hotSearchView!.frame.size.height = hotSearchView!.searchHeight
                
                contentScrollView.addSubview(hotSearchView!)
            }
        }
    }
    
    private func loadHistorySearchButtonData(){
    
        if historySearchView != nil {
            historySearchView?.removeFromSuperview()
            historySearchView = nil
        }
        weak var weakSelf = self
        let array = NSUserDefaults.standardUserDefaults().objectForKey(LFBSearchViewControllerHistorySearchArray) as? [String]
        if array?.count > 0 {
            historySearchView = SearchView(frame: CGRectMake(10, CGRectGetMaxY(hotSearchView!.frame) + 20, ScreenWidth - 20, 0), searchTitleText: "历史记录", searchButtonTitleTexts: array!, searchButtonClickCallback: { (sender) in
                weakSelf?.searchBar.text = sender.titleForState(.Normal)
                weakSelf?.loadProductsWithKeyword(sender.titleForState(.Normal))
            })
            historySearchView?.frame.size.height = historySearchView!.searchHeight
            contentScrollView.addSubview(historySearchView!)
            updateCleanHistoryButton(false)
        }
        contentScrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(cleanHistoryButton.frame) + 90)

    }
    
    private func setUpCleanHistorySearchButton(){
    
        cleanHistoryButton.setTitle("清 空 历 史", forState: .Normal)
        cleanHistoryButton.setTitleColor(UIColor.colorWithCustom(163, g: 163, b: 163), forState: .Normal)
        cleanHistoryButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        cleanHistoryButton.backgroundColor = view.backgroundColor
        cleanHistoryButton.layer.borderWidth = 0.5
        cleanHistoryButton.layer.cornerRadius = 5
        cleanHistoryButton.layer.borderColor = UIColor.colorWithCustom(200, g: 200, b: 200).CGColor
        cleanHistoryButton.hidden = true
        cleanHistoryButton.addTarget(self, action: #selector(SearchProductViewController.cleanSearchHistorySearch), forControlEvents: .TouchUpInside)
        contentScrollView.addSubview(cleanHistoryButton)

    }
    
    private func updateCleanHistoryButton(hidden:Bool){
    
        if historySearchView != nil {
            cleanHistoryButton.frame = CGRectMake(0.1 * ScreenWidth, CGRectGetMaxY(historySearchView!.frame) + 20, ScreenWidth * 0.8, 40)
        }
        cleanHistoryButton.hidden = hidden
    }

    
    // MARK: - Action
    func cleanSearchHistorySearch() {
        var historySearch = NSUserDefaults.standardUserDefaults().objectForKey(LFBSearchViewControllerHistorySearchArray) as? [String]
        historySearch?.removeAll()
        NSUserDefaults.standardUserDefaults().setObject(historySearch, forKey: LFBSearchViewControllerHistorySearchArray)
        loadHistorySearchButtonData()
        updateCleanHistoryButton(true)
        contentScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight)

    }
    
    func leftButtonClcik() {
        searchBar.endEditing(false)
        
    }
    
    // MARK: - Private Method
    func loadProductsWithKeyword(keyWord: String?) {
        if keyWord == nil || keyWord?.characters.count == 0 {
            return
        }
        
        ProgressHUDManager.setBackgroundColor(UIColor.whiteColor())
//        ProgressHUDManager.showSuccessWithStatus("加载成功")

        
    }
    
    private func writeHistorySearchToUserDefault(str: String) {
        var historySearch = NSUserDefaults.standardUserDefaults().objectForKey(LFBSearchViewControllerHistorySearchArray) as? [String]
        for text in historySearch! {
            if text == str {
                return
            }
        }
        historySearch!.append(str)
        NSUserDefaults.standardUserDefaults().setObject(historySearch, forKey: LFBSearchViewControllerHistorySearchArray)
        loadHistorySearchButtonData()
    }

}


extension SearchProductViewController: UISearchBarDelegate, UIScrollViewDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        if searchBar.text?.characters.count > 0 {
            
            writeHistorySearchToUserDefault(searchBar.text!)
            
            loadProductsWithKeyword(searchBar.text!)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        searchBar.endEditing(false)
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count == 0 {
            searchCollectionView?.hidden = true
            yellowShopCar?.hidden = true
        }
    }
}
