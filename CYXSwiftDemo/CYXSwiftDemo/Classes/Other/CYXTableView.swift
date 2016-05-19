//
//  CYXTableView.swift
//  CYXSwiftDemo
//
//  Created by apple开发 on 16/5/19.
//  Copyright © 2016年 cyx. All rights reserved.
//

import UIKit

class CYXTableView: UITableView {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        delaysContentTouches = false
        canCancelContentTouches = true
        
        let wrapView = subviews.first
        
        if wrapView != nil && NSStringFromClass((wrapView?.classForCoder)!).hasPrefix("WrapperView") {
            for gesture in wrapView!.gestureRecognizers! {
                if NSStringFromClass(gesture.classForCoder).containsString("DelayedTouchesBegan") {
                    gesture.enabled = false
                    break
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesShouldCancelInContentView(view: UIView) -> Bool {
        if view.isKindOfClass(UIControl) {
            return true
        }
        return super.touchesShouldCancelInContentView(view)
    }

}
