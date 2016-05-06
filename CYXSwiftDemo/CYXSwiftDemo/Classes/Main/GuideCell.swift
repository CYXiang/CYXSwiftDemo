//
//  NewCharacteristicsCell.swift
//  CYXSwiftDemo
//
//  Created by apple开发 on 16/5/5.
//  Copyright © 2016年 cyx. All rights reserved.
//

import UIKit

class GuideCell: UICollectionViewCell {
    
    private let newImageView = UIImageView(frame: ScreenBounds)
    private let nextButton = UIButton(frame: CGRectMake((ScreenWidth - 100) * 0.5, ScreenHeight - 110, 100, 33))
    
    var newImage: UIImage? {
        didSet {
            newImageView.image = newImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        newImageView.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(newImageView)
        
        nextButton.setBackgroundImage(UIImage(named: "icon_next"), forState: UIControlState.Normal)
        nextButton.addTarget(self, action: #selector(GuideCell.nextButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        nextButton.hidden = true
        contentView.addSubview(nextButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNextButtonHidden(hidden: Bool) {
        nextButton.hidden = hidden
    }
    
    func nextButtonClick() {
        NSNotificationCenter.defaultCenter().postNotificationName(GuideViewControllerDidFinish, object: nil)
    }
}
