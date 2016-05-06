//
//  HomeTableViewController.swift
//  CYXSwiftDemo
//
//  Created by Macx on 15/11/7.
//  Copyright © 2015年 cyx. All rights reserved.
//

import UIKit

class HomeTableViewController: UIViewController {

    private var flag: Int = -1
    private var collectionView: UICollectionView!
    private var lastContentOffsetY: CGFloat = 0
    private var isAnimation: Bool = false
    private var freshHot: NSObject?

    // MARK: Life circle
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: HomeCollectionViewCellMargin, bottom: 0, right: HomeCollectionViewCellMargin)
        layout.headerReferenceSize = CGSizeMake(0, HomeCollectionViewCellMargin)
        
        collectionView = UICollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = LFBGlobalBackgroundColor
        collectionView.registerClass(HomeCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
        
        let refreshHeadView = LFBRefreshHeader(refreshingTarget: self, refreshingAction: #selector(HomeTableViewController.headRefresh))
        refreshHeadView.gifView?.frame = CGRectMake(0, 30, 100, 100)
        collectionView.mj_header = refreshHeadView
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBar.barTintColor = LFBNavigationYellowColor;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: 刷新
    func headRefresh() {
        freshHot = nil
//        var headDataLoadFinish = false
//        var freshHotLoadFinish = false
        
        weak var tmpSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
//            HeadResources.loadHomeHeadData { (data, error) -> Void in
//                if error == nil {
//                    headDataLoadFinish = true
//                    tmpSelf?.headView?.headData = data
//                    tmpSelf?.headData = data
//                    if headDataLoadFinish && freshHotLoadFinish {
//                        tmpSelf?.collectionView.reloadData()
                        tmpSelf?.collectionView.mj_header.endRefreshing()
//                    }
//                }
            }
            
//            FreshHot.loadFreshHotData { (data, error) -> Void in
//                freshHotLoadFinish = true
//                tmpSelf?.freshHot = data
//                if headDataLoadFinish && freshHotLoadFinish {
//                    tmpSelf?.collectionView.reloadData()
                    tmpSelf?.collectionView.mj_header.endRefreshing()
//                }
//            }
        }
    }
    





// MARK: - CollectionView data source

extension HomeTableViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! HomeCell
        
        if indexPath.section == 0 {

        } else if indexPath.section == 1 {

            cell.addButtonClick = ({ (imageView) -> () in

            })
        }
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var itemSize = CGSizeZero
        if indexPath.section == 0 {
            itemSize = CGSizeMake(ScreenWidth - HomeCollectionViewCellMargin * 2, 140)
        } else if indexPath.section == 1 {
            itemSize = CGSizeMake((ScreenWidth - HomeCollectionViewCellMargin * 2) * 0.5 - 4, 250)
        }
        
        return itemSize
    }
    
    func collectionView(collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 && freshHot != nil && isAnimation {
            startAnimation(view, offsetY: 60, duration: 0.8)
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1) {
            return
        }
        
        if isAnimation {
            startAnimation(cell, offsetY: 80, duration: 1.0)
        }
    }
    
    private func startAnimation(view: UIView, offsetY: CGFloat, duration: NSTimeInterval) {
        
        view.transform = CGAffineTransformMakeTranslation(0, offsetY)
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            view.transform = CGAffineTransformIdentity
        })
    }
    
    // MARK: - ScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {

        
        
        if scrollView.contentOffset.y <= scrollView.contentSize.height {
            isAnimation = lastContentOffsetY < scrollView.contentOffset.y
            lastContentOffsetY = scrollView.contentOffset.y
        }
    }


    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            CYXLog("点击了第一组")
        } else {
            CYXLog("点击了第二组")
        }
    }
}
