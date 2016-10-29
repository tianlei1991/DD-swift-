//
//  DDNavigationViewController.swift
//  diaodiao
//
//  Created by honey on 16/5/3.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit

class DDNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationBar.setBackgroundImage(UIImage(named: "TabBarBackground"), forBarMetrics: .Default)
        
        
    }

    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
