//
//  ZDMController.swift
//  diaodiao
//
//  Created by honey on 16/5/4.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit

class ZDMSwitchController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let segme = UISegmentedControl(items: ["列表模式", "图片模式"])
        
        segme.tintColor = UIColor.whiteColor()
        
        segme.selectedSegmentIndex = 0
        
        segme.addTarget(self, action: #selector(change), forControlEvents: .ValueChanged)
        
        self.navigationItem.titleView = segme
    }

    func change(sender:UISegmentedControl)  {
        
        self.selectedIndex = sender.selectedSegmentIndex
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
