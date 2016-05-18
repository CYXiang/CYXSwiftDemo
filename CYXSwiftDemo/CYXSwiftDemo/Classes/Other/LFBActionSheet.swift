//
//  LFBActionSheetManger.swift
//  CYXSwiftDemo
//
//  Created by apple开发 on 16/5/6.
//  Copyright © 2016年 cyx. All rights reserved.
//

import UIKit

enum ShareType: Int {
    case WeiXinMyFriend = 1
    case WeiXinCircleOfFriends = 2
    case SinaWeiBo = 3
    case QQZone = 4
}

class LFBActionSheet: NSObject, UIActionSheetDelegate {
    
    private var selectedShaerType: ((shareType: ShareType) -> ())?
    private var actionSheet: UIActionSheet?
    
    func showActionSheetViewShowInView(inView: UIView, selectedShaerType: ((shareType: ShareType) -> ())) {
        
        actionSheet = UIActionSheet(title: "分享到",
            delegate: self, cancelButtonTitle: "取消",
            destructiveButtonTitle: nil,
            otherButtonTitles: "微信好友", "微信朋友圈", "新浪微博", "QQ空间")
        
        self.selectedShaerType = selectedShaerType
        
        actionSheet?.showInView(inView)
        
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        print(buttonIndex)
        if selectedShaerType != nil {
            
            switch buttonIndex {

            case ShareType.WeiXinMyFriend.rawValue:
                selectedShaerType!(shareType: .WeiXinMyFriend)
                break
                
            case ShareType.WeiXinCircleOfFriends.rawValue:
                selectedShaerType!(shareType: .WeiXinCircleOfFriends)
                break
                
            case ShareType.SinaWeiBo.rawValue:
                selectedShaerType!(shareType: .SinaWeiBo)
                break
                
            case ShareType.QQZone.rawValue:
                selectedShaerType!(shareType: .QQZone)
                break
                
            default:
                break
            }
        }
    }
    
}
