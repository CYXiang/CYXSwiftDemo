//
//  ProfileTableViewController.swift
//  CYXSwiftDemo
//
//  Created by Macx on 15/11/7.
//  Copyright © 2015年 cyx. All rights reserved.
//

import UIKit

class ProfileTableViewController: BaseViewController {

    
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
        
    }
    
    // MARK: - CreatUI
    private func buildUI(){
    
        
        
    }


}
