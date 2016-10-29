//
//  ZDMDetailViewController.swift
//  diaodiao
//
//  Created by honey on 16/5/6.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit

class ZDMDetailViewController: DDBaseViewController {

    var buyLink:String?
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let leftImage = UIImage(named: "IconBack")
        let button = UIButton(type: .Custom)
        button.setBackgroundImage(leftImage, forState: .Normal)
        button.frame = CGRectMake(0, 0, leftImage!.size.width, leftImage!.size.height)
        button.addTarget(self, action: #selector(gooback), forControlEvents: .TouchUpInside)
        let leftItem = UIBarButtonItem(customView: button)
        
        self.title = "调调"
        
        self.navigationItem.leftBarButtonItem = leftItem
        
        
        if let link = self.buyLink {
            
            let request = NSURLRequest(URL: NSURL(string: link)!)
            
            webView.loadRequest(request)
            
        }
        
    }
    
    func gooback() {
        if self.webView.canGoBack {
            self.webView.goBack()
        }
        else
        {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }

  
}
