//
//  DDTabbarViewController.swift
//  diaodiao
//
//  Created by honey on 16/4/14.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit

class DDTabbarViewController: UITabBarController {
    
    var tabbr_custom:UIView!
    
    let screenWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
    let screenHeight = CGRectGetHeight(UIScreen.mainScreen().bounds)
    
    let norImages = ["TabBarIcon_DD", "TabBarIcon_WorthBuy", "TabBarIcon_Discover", "TabBarIcon_User"]
    let pressImages = ["TabBarIcon_DD_Highlight", "TabBarIcon_WorthBuy_Highlight", "TabBarIcon_Discover_Highlight", "TabBarIcon_User_Highlight"]
    
    
    var currentSelect:UIButton! //当前选中的选项

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.layoutTabbar()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
 
    
    //MARK: - 自定义tabbar
    func layoutTabbar() -> Void {
        
//        self.tabBar.removeFromSuperview()
        
        let backgroundImage = UIImage(named: "TabBarBackground")
        let background = UIImageView(image: backgroundImage)
        background.frame = CGRectMake(0, 0, screenWidth, backgroundImage!.size.height / 2)
        
        self.tabbr_custom = UIView(frame: CGRectMake(0, 0, screenWidth, backgroundImage!.size.height / 2))
        
        self.tabbr_custom.addSubview(background)
        
        
        let btnWidth = self.screenWidth / CGFloat(self.norImages.count)
        let btnHeight = CGFloat(backgroundImage!.size.height / 2)
        
        for i in 0 ..< self.norImages.count {
            let button = UIButton(type: .Custom)
            
            button.frame = CGRectMake(CGFloat(i) * btnWidth, 0, btnWidth, btnHeight)
            
            
            button.setImage(UIImage(named: self.norImages[i]), forState: .Normal)
            button.setImage(UIImage(named: self.pressImages[i]), forState: .Selected)
            
            button.tag = i
            
            button.addTarget(self, action: #selector(switchViewController(_:)), forControlEvents: .TouchUpInside)
            
            if i == 0 {
                button.selected = true
                self.currentSelect = button
            }
            
            self.tabbr_custom .addSubview(button)
        }
        
        self.tabBar.addSubview(self.tabbr_custom)
    }
    
    func switchViewController(sender:UIButton) -> Void {
        
        self.currentSelect.selected = false
        
        sender.selected = true
        
        
        self.selectedIndex = sender.tag
        
        self.currentSelect = sender        
    }
    
}






