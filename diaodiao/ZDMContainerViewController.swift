//
//  ZDMContainerViewController.swift
//  diaodiao
//
//  Created by honey on 16/5/4.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit

class ZDMContainerViewController: DDBaseViewController {
    

    @IBOutlet var viewControllers = [UIViewController]() //存放子控制器
    
    private var currentViewController:UIViewController?
    
    override func awakeFromNib() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.layoutSubControllerView()
    }
    
    
    
    func layoutSubControllerView() {
        
        for (i,vc) in self.viewControllers.enumerate() {
            
            let subViewControllerView = vc.view
            
            subViewControllerView.frame = CGRectMake(CGFloat(i) * CGRectGetWidth(self.view.frame), 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))
            
            self.view.addSubview(subViewControllerView)
            
            self.addChildViewController(vc)
        }
        
        self.viewControllers.first?.didMoveToParentViewController(self)
        self.currentViewController = self.viewControllers.first
        
        
    }
    
    
    func switchController(index:Int)  {
        
        
        let toViewController = self.viewControllers[index]
        
        if toViewController != self.currentViewController {
            
            self.transitionFromViewController(self.currentViewController!, toViewController: toViewController, duration: 0.3, options: UIViewAnimationOptions.TransitionNone, animations: nil, completion: nil)
            
            toViewController.didMoveToParentViewController(self)
            
            self.currentViewController?.removeFromParentViewController()
            
            self.currentViewController = toViewController
        }
        
    }
    
}












