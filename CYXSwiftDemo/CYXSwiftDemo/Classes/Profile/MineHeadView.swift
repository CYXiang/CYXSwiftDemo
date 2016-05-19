 //
//  MineHeadView.swift
//  CYXSwiftDemo
//
//  Created by apple开发 on 16/5/18.
//  Copyright © 2016年 cyx. All rights reserved.
//

import UIKit

class MineHeadView: UIImageView {


    let setUpBtn: UIButton = UIButton(type: UIButtonType.Custom)
    let iconView: IconView = IconView()
    var buttonClick: (Void -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image = UIImage(named: "v2_my_avatar_bg")
        setUpBtn.setImage(UIImage(named: "v2_my_settings_icon"), forState: .Normal)
        setUpBtn.addTarget(self, action: #selector(MineHeadView.setUpBtnClick), forControlEvents: .TouchUpInside)
        addSubview(setUpBtn)
        addSubview(iconView)
        self.userInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let iconViewWH: CGFloat = 150
        iconView.frame = CGRectMake((width - 150) * 0.5, 30, iconViewWH, iconViewWH)
        setUpBtn.frame = CGRectMake(width - 50, 10, 50, 50)
        
    }
    
    func setUpBtnClick() {
        buttonClick?()
    }
    
}
 
 class IconView: UIView {
    var iconImageView: UIImageView!
    var phoneNum: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconImageView = UIImageView(image: UIImage(named: "v2_my_avatar"))
        addSubview(iconImageView)
        
        phoneNum = UILabel()
        phoneNum.text = "18612348765"
        phoneNum.font = UIFont.boldSystemFontOfSize(18)
        phoneNum.textColor = UIColor.whiteColor()
        phoneNum.textAlignment = .Center
        addSubview(phoneNum)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.frame = CGRectMake((width - iconImageView.size.width) * 0.5, 0, iconImageView.size.width, iconImageView.size.height)
        phoneNum.frame = CGRectMake(0, CGRectGetMaxY(iconImageView.frame) + 5, width, 30)
    }
    
    
 }
