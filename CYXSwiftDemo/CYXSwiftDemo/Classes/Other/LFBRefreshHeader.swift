//
//  LFBRefreshHeader.swift
//  CYXSwiftDemo
//
//  Created by apple开发 on 16/5/5.
//  Copyright © 2016年 cyx. All rights reserved.
//

import UIKit

class LFBRefreshHeader: MJRefreshGifHeader {

    override func prepare() {
        super.prepare()
        stateLabel?.hidden = false
        lastUpdatedTimeLabel?.hidden = true
        
        setImages([UIImage(named: "v2_pullRefresh1")!], forState: MJRefreshState.Idle)
        setImages([UIImage(named: "v2_pullRefresh2")!], forState: MJRefreshState.Pulling)
        setImages([UIImage(named: "v2_pullRefresh1")!, UIImage(named: "v2_pullRefresh2")!], forState: MJRefreshState.Refreshing)
        
        setTitle("下拉刷新", forState: .Idle)
        setTitle("松手开始刷新", forState: .Pulling)
        setTitle("正在刷新", forState: .Refreshing)
    }
}
