//
//  ProfileTableViewController.swift
//  CYXSwiftDemo
//
//  Created by Macx on 15/11/7.
//  Copyright © 2015年 cyx. All rights reserved.
//

import UIKit

class ProfileTableViewController: BaseViewController {

    private var headView: MineHeadView!
    private var tableView: CYXTableView!
    private var headViewHeight: CGFloat = 150
    private var couponNum: Int = 0
    private let shareActionSheet: LFBActionSheet = LFBActionSheet()
    
//    private lazy var mines: [MineCellModel]
    
    // MARK: - Lief Cycle
    override func loadView() {
        super.loadView()
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildUI()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        weak var weakSelf = self
        
        
    }
    
    // MARK: - CreatUI
    private func buildUI(){
    
        
        
    }


}
